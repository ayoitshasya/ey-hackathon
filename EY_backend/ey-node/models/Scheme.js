import mongoose from 'mongoose';

const schemeSchema = new mongoose.Schema({
  'Scheme Name': {
    type: String,
    required: true
  },
  'Category': String,
  'Under Who': String,
  'Details': String,
  'Benefits': String,
  'Eligibility': String,
  'Exclusions': String,
  'Application Process': String,
  'Documents Required': String,
  'Funding Type': String,
  'Target Audience': String,
  'Official Website': String,
  'Minimum Income': Number,
  'Maximum Income': Number,
  'Minimum Age': Number,
  'Maximum Age': Number,
  'Gender': {
    type: String,
    enum: ['male', 'female', 'other', 'all'],
    default: 'all'
  },
  'State': {
    type: String,
    required: true
  },
  'Reservation Category': {
    type: String,
    enum: ['sc', 'st', 'obc', 'general', 'all'],
    default: 'all'
  }
});

export default mongoose.model('Scheme', schemeSchema); 