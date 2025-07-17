# MOVIE SEARCH APPLICATION CHALLENGE
> Created by Beatriz Del Pinal.
>> Flutter version: (stable / 3.32.2 / 8defaa71a7)

This application allows users to search for movies by title using the OMDb API, display organized search results, and view detailed information for each selected movie,
This project will use:
- **BLoC**  
- **Clean Code Architecture**  
- **Error Handling**


## Folder Structure

The project follows a Clean Code Architecture with separation of responsibilities into **data**, **logic**, and **views** layers.

```text
lib/
├── core/                          # Shared code
│   ├── config/                    # ApiConfig, constants
│   ├── error/                     # Failure, Exception
│   ├── network/                   # NetworkInfo, interceptors
│   └── usecases/                  # Generic UseCase interface
│
├── features/                      # Functional modules
│   └── movies/                    # Movies feature
│       ├── data/                  # Infrastructure: HTTP, JSON, repo impl. 
│       │   ├── datasources/       
│       │   ├── models/            
│       │   └── repositories/      
│       │
│       ├── logic/                 # Business logic
│       │   ├── entities/          
│       │   ├── repositories/      
│       │   └── usecases/          
│       │
│       └── views/                 # UI + state (BLoC)
│           ├── bloc/              
│           ├── screens/           
│           └── widgets/           
│
└── main.dart                      # Entry point and routing
```
