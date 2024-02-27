List<String> specs = [
  'Software Development',
  'web Development',
  'Data Science and Analytics',
  'Cybersecurity',
  'Database Management',
  'Quality Assurance'
];
List<String>? jobTitle(int defaultChoiceIndex1) {
  if (defaultChoiceIndex1 == null) {
    return []; // Return an empty list for null input
  } else if (defaultChoiceIndex1 == 0) {
    return [
      'Software Engineer',
      'Full-Stack Developer',
      'Front-End Developer',
      'Back-End Developer',
      'Mobile App Developer (iOS/Android)',
      'Game Developer',
      'Embedded Systems Developer',
    ];
  } else if (defaultChoiceIndex1 == 1) {
    return [
      'Web Developer',
      'UI/UX Designer',
      'DevOps Engineer',
      'Cloud Engineer',
    ];
  } else if (defaultChoiceIndex1 == 2) {
    return [
      'Data Scientist',
      'Data Analyst',
      'Machine Learning Engineer',
      'Business Intelligence Developer',
    ];
  } else if (defaultChoiceIndex1 == 3) {
    return [
      'Security Analyst',
      'Ethical Hacker',
      'Security Engineer',
    ];
  } else if (defaultChoiceIndex1 == 4) {
    return [
      'Database Administrator (DBA)',
      'Database Developer',
    ];
  } else if (defaultChoiceIndex1 == 5) {
    return [
      'QA Engineer',
      'Automation Tester',
    ];
  }
}

// List<String> SoftwareDevelopment = [
//   'Software Engineer',
//   'Full-Stack Developer',
//   'Front-End Developer',
//   'Back-End Developer',
//   'Mobile App Developer (iOS/Android)',
//   'Game Developer',
//   'Embedded Systems Developer',
// ];
// List<String> webDevelopment = [
//   'Web Developer',
//   'UI/UX Designer',
//   'DevOps Engineer',
//   'Cloud Engineer',
// ];

// List<String> DataScience = [
//   'Data Scientist',
//   'Data Analyst',
//   'Machine Learning Engineer',
//   'Business Intelligence Developer',
// ];
// List<String> Cybersecurity = [
//   'Security Analyst',
//   'Ethical Hacker',
//   'Security Engineer',
// ];
// List<String> DatabaseManagement = [
//   'Database Administrator (DBA)',
//   'Database Developer',
// ];
// List<String> QualityAssurance = [
//   'QA Engineer',
//   'Automation Tester',
// ];
