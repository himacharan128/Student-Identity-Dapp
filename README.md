# Digital Identity DApp (STUDENT IDENTITY)

This project implements a decentralized application (DApp) called Digital Identity, which provides identity management solutions using blockchain technology. Users can register, validate, and access identity-related information securely through this platform.
## Project Structure
```bash
digitalIdentity/
  ├── client/
  │   ├── package.json
  │   ├── public/
  │   └── src/
  │       ├── App.js
  │       ├── components/
  │       │   ├── AdminDashboard.js
  │       │   ├── UserDashboard.js
  │       │   ├── VerifyDetails.js
  │       │   ├── UserRegistration.js
  │       │   └── ... (other component files)
  │       ├── hooks/
  │       │   └── useWeb3.js (or similar file for web3 connection)
  │       │   └── ... (other hook files if needed)
  │       ├── images/
  │       │   └── ... (image files for UI)
  │       ├── index.js
  │       └── pages/
  │           ├── AdminLoginPage.js
  │           ├── UserLoginPage.js
  │           └── VerifyDetailsPage.js  
  │               └── ... (other page component files)
  │       └── ... (other React files)
  ├── contracts/
  │   ├── DigiIdentity.sol
  │   └── ... (other contract files if needed)
  ├── migrations/
  │   └── 1_initial_migration.js (or numbered migration files)
  ├── truffle-config.json
  └── package.json (project-level dependencies)
  └── README.md
```

## Product Description

The Digital Identity DApp consists of three main pages:

1. **Admin Page**: Allows administrators to validate user applications, manage user data, and verify user details.
2. **User Page**: Provides functionality for users to generate, access, and manage their identities securely.
3. **Verify Details Page**: Facilitates the verification process for verifying candidate details using QR code scanning and OTP authentication.

### Admin Module Functionalities

1. **Dashboard Overview**: Displays an overview of active users, registered users pending approval, and rejected users.
2. **User Management**:
   - **Active Users**: View and manage users who are currently active.
   - **Registered Users**: Review and accept/reject user applications.
   - **Rejected Users**: View and manage users whose applications were previously rejected.
3. **User Verification Process**: Verify user details uploaded during the registration process.

### User Module Functionalities

1. **User Authentication**: Users authenticate using Auth0.
2. **User Dashboard**: Allows users to fill in personal details, upload documents, and submit for validation.
3. **Verification Process**: Users receive OTP on email for validating their identity after submitting their details.

### Post-Activation Enhancement

- **QR Code Generation**: Users can generate a unique QR code that displays their profile and limited details.

## Home Page
```bash
ADMIN LOGIN | USER LOGIN | VERIFY DETAILS
```
### Admin Page
```bash
REGISTERED USERS | ACTIVE USERS | REJECTED USERS
```

## Technical Requirements

- **Front-end**: React
- **Blockchain**: Ethereum (Solidity) with Ganache Truffle.
- **Interaction Library**: web3.js

### Contract Deployment

- Ensure that the smart contract has been successfully deployed to the correct network. Double-check the network ID in MetaMask and compare it with the network ID specified in the `DigiIdentityContract.json` file.

### User Login Issue

- If encountering issues like "Loading contract..." without any progress, check the contract deployment and MetaMask network connection.

### Error Handling

- Error messages may occur due to incorrect network settings or contract deployment issues. Ensure all configurations are correctly set up.
#### User Login Issue

- If encountering issues like "Loading contract..." without any progress, check the contract deployment and MetaMask network connection.

#### Error Handling

- Error messages may occur due to incorrect network settings or contract deployment issues. Ensure all configurations are correctly set up.

### Contract Deployment

Ensure that the smart contract has been successfully deployed to the correct network. Double-check the network ID in MetaMask and compare it with the network ID specified in the `DigiIdentityContract.json` file.

## Usage

To run the Digital Identity DApp:

1. Clone the repository to your local machine.
2. Navigate to the `client` directory and run `npm install` to install dependencies.
3. Ensure that you have Ganache Truffle set up and running with the correct network configuration.
4. Compile and migrate the smart contracts using Truffle.
5. Update the `DigiIdentityContract.json` file with the correct contract address.
6. Start the React app by running `npm start`.
7. Open the application in your browser and connect MetaMask to the appropriate network.

## License

This project is licensed under the [MIT License](https://opensource.org/licenses/MIT).

