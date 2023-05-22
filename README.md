<p align="center">
    <img src="https://img.shields.io/badge/Swift-5.7-orange.svg" />
    <img src="https://img.shields.io/badge/Xcode-14.2.X-orange.svg" />
    <img src="https://img.shields.io/badge/platforms-iOS-brightgreen.svg?style=flat" alt="iOS" />
    <a href="https://www.linkedin.com/in/nelson-junior-70b113100/" target="_blank">
        <img src="https://img.shields.io/badge/LinkedIn-@NelsonJunior-blue.svg?style=flat" alt="LinkedIn: @NelsonJunior" />
    </a>
</p>

# Mercado Bitcoin

    Mercado Bitcoin is a simple app that get the most out of cryptocurrency markets, so you can make informative decisions on buying or selling them.
    
<p align="left">
    <img src="https://media.giphy.com/media/0A9oKqQhwYszfgOKaZ/giphy.gif" width="300" max-width="40%" alt="Mercado Bitcoin"/>
</p>

## Contents

- [Requirements](#requirements)
- [About](#about)
- [Functionalities](#functionalities)
- [Setup](#setup)
- [Tests](#tests)
- [Credits](#credits)

## Requirements

- iOS 16.0 or later
- Xcode 14.0 or later
- Swift 5.0 or later

### About:

- [Quick](https://github.com/Quick/Quick) - The Swift (and Objective-C) testing framework.
- [Nimble](https://github.com/Quick/Nimble) - A Matcher Framework for Swift and Objective-C
- [Nimble-Snapshots](https://github.com/ashfurrow/Nimble-Snapshots) - Nimble matchers for FBSnapshotTestCase

## Functionalities
- [x] Listagem repositórios.
- [x] Detalhes e listagem das requests.
- [x] Testes unitários para ViewModel.
- [x] Testes de UI

## Setup

First of all download and install Xcode, Cocoapods and then clone the repository:

```sh
$ git@github.com:Junior-iOS/MercadoBitcoin.git
```

After cloning, do the following:

```sh
$ cd <diretorio-base>/MercadoBitcoin/
$ pod install
```
## Tests

    To simplify the unit test was created the mock mode. 
    The mock mode is another target inside the application containing a mock network provider to avoid performing async requests in unit testing and make it easier to run UITests.
    If you want to run all tests, certify that you run them on MercadoBitcoinMock scheme.

## Credits

- NJ Development® by Nelson Junior
