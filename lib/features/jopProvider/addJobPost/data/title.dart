List<String>? title(String sepeclization) {
  if (sepeclization == null) {
    return []; // Return an empty list for null input
  } else if (sepeclization == 'Software Development') {
    return [
      'Software Engineer',
      'Full-Stack Developer',
      'Front-End Developer',
      'Back-End Developer',
      'Mobile App Developer (iOS/Android)',
      'Game Developer',
      'Embedded Systems Developer',
    ];
  } else if (sepeclization == 'web Development') {
    return [
      'Web Developer',
      'UI/UX Designer',
      'DevOps Engineer',
      'Cloud Engineer',
    ];
  } else if (sepeclization == 'Data Science and Analytics') {
    return [
      'Data Scientist',
      'Data Analyst',
      'Machine Learning Engineer',
      'Business Intelligence Developer',
    ];
  } else if (sepeclization == 'Cybersecurity') {
    return [
      'Security Analyst',
      'Ethical Hacker',
      'Security Engineer',
    ];
  } else if (sepeclization == 'Database Management') {
    return [
      'Database Administrator (DBA)',
      'Database Developer',
    ];
  } else if (sepeclization == 'Quality Assurance') {
    return [
      'QA Engineer',
      'Automation Tester',
    ];
  }
}
