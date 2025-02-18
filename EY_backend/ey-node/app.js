import express from 'express';
import mongoose from 'mongoose';
import dotenv from 'dotenv';
import User from './models/User.js';
import Scheme from './models/Scheme.js';

dotenv.config();

const app = express();

// Middleware
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// MongoDB connection
mongoose.connect('mongodb+srv://dhiwarashish4:magh8k9ixchIdaRV@eytechathon.amqtt.mongodb.net/?retryWrites=true&w=majority&appName=eytechathon')
  .then(() => console.log('Connected to MongoDB'))
  .catch(err => console.error('MongoDB connection error:', err));

// Basic route
app.get('/', (req, res) => {
  res.json({ message: 'Welcome to the API' });
});

// POST route to add a new user
app.post('/api/users', async (req, res) => {
  try {
    // Validate required fields
    const requiredFields = [
      'firstName', 
      'lastName', 
      'aadharNumber', 
      'phoneNumber', 
      'gender', 
      'age', 
      'annualIncome', 
      'sourceOfIncome', 
      'category'
    ];

    const missingFields = requiredFields.filter(field => !req.body[field]);
    if (missingFields.length > 0) {
      return res.status(400).json({
        message: 'Missing required fields',
        missingFields
      });
    }

    const user = new User(req.body);
    const savedUser = await user.save();
    
    res.status(201).json({
      message: 'User created successfully',
      data: savedUser
    });

  } catch (error) {
    // Handle specific validation errors
    if (error.code === 11000) {
      return res.status(400).json({
        message: 'Duplicate entry',
        error: 'Aadhar number already exists'
      });
    }

    if (error.name === 'ValidationError') {
      return res.status(400).json({
        message: 'Validation error',
        errors: Object.values(error.errors).map(err => ({
          field: err.path,
          message: err.message
        }))
      });
    }

    res.status(400).json({
      message: 'Error creating user',
      error: error.message
    });
  }
});

// New route to fetch eligible schemes
app.post('/api/schemes/eligible', async (req, res) => {
  try {
    // Validate required fields
    const requiredFields = [
      'age',
      'annualIncome',
      'gender',
      'state',
      'category'
    ];

    const missingFields = requiredFields.filter(field => !req.body[field]);
    if (missingFields.length > 0) {
      return res.status(400).json({
        message: 'Missing required fields',
        missingFields
      });
    }

    const { age, annualIncome, gender, state, category } = req.body;

    // Build the query conditions
    const query = {
      $and: [
        // Age criteria
        {
          $or: [
            { 'Minimum Age': { $lte: age } },
            { 'Minimum Age': null }
          ]
        },
        {
          $or: [
            { 'Maximum Age': { $gte: age } },
            { 'Maximum Age': null }
          ]
        },
        // Income criteria
        {
          $or: [
            { 'Minimum Income': { $lte: annualIncome } },
            { 'Minimum Income': null }
          ]
        },
        {
          $or: [
            { 'Maximum Income': { $gte: annualIncome } },
            { 'Maximum Income': null }
          ]
        },
        // Gender criteria
        {
          $or: [
            { Gender: gender.toLowerCase() },
            { Gender: 'all' }
          ]
        },
        // State criteria
        {
          $or: [
            { State: state },
            { State: 'All' }
          ]
        },
        // Reservation category criteria
        {
          $or: [
            { 'Reservation Category': category.toLowerCase() },
            { 'Reservation Category': 'all' }
          ]
        }
      ]
    };

    // Fetch schemes from database
    const schemes = await mongoose.model('Scheme').find(query);

    res.json({
      message: 'Eligible schemes fetched successfully',
      count: schemes.length,
      data: schemes
    });

  } catch (error) {
    res.status(500).json({
      message: 'Error fetching eligible schemes',
      error: error.message
    });
  }
});

// POST route to add multiple schemes
app.post('/api/schemes/bulk', async (req, res) => {
  try {
    // Validate if schemes array is provided
    if (!Array.isArray(req.body)) {
      return res.status(400).json({
        message: 'Request body should be an array of schemes'
      });
    }

    // Insert all schemes
    const result = await Scheme.insertMany(req.body, {
      ordered: false // Continues insertion even if some documents fail
    });

    res.status(201).json({
      message: 'Schemes added successfully',
      count: result.length,
      data: result
    });

  } catch (error) {
    // Handle bulk write errors
    if (error.writeErrors) {
      return res.status(400).json({
        message: 'Some schemes failed to insert',
        successCount: error.insertedDocs.length,
        failureCount: error.writeErrors.length,
        errors: error.writeErrors.map(err => ({
          index: err.index,
          error: err.errmsg
        }))
      });
    }

    res.status(500).json({
      message: 'Error adding schemes',
      error: error.message
    });
  }
});

// Start server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
}); 