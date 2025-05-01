# Security Policy

## Supported Versions

Currently supported versions of World Quest for security updates:

| Version | Supported          |
| ------- | ------------------ |
| 1.0.x   | :white_check_mark: |

## Reporting a Vulnerability

We take the security of World Quest seriously. If you believe you've found a security vulnerability, please follow these steps:

1. **Do not disclose the vulnerability publicly**
2. **Email us directly at [security@worldquest.example.com](mailto:security@worldquest.example.com)** with:
   - Description of the vulnerability
   - Steps to reproduce
   - Potential impact
   - Any suggestions for mitigation if possible

## Security Measures

World Quest implements the following security best practices:

- User data is stored securely in Firebase with proper authentication
- No sensitive data is stored locally on devices
- Network communications use HTTPS/SSL
- Regular security updates and code reviews

## Environment Variables

For developers working on the project, sensitive information like API keys should be stored in a `.env` file that is not committed to the repository. This file is already included in our `.gitignore`.

## Third-Party Dependencies

We regularly update and audit our dependencies to address known vulnerabilities. The project uses Flutter's secure coding practices and follows Google's security recommendations for mobile apps.