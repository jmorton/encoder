# Encode

## About

Encode makes it easy use get meaningful descriptions from encoded values.

    task.status = 'P'
    task.status.decode # => 'Pending'
    
It also simplifies using constants to define encoded values and descriptions.

    task.status = Task::Status::New
    task.status # => 'N'
    task.status.decode # => 'New'

## Observations

1. Magic numbers and characters make code more difficult to maintain because they don't have instrinsic meaning.
1. Magic strings, while meaningful, make code more difficult to maintain because minor variations can cause subtle problems.
1. Literal values scattered throughout a codebase increase refactoring time and effort.
1. Mapping between encoded values and descriptions shouldn't require a lot of effort.

## Using Encoder

### Setup
<script src="http://gist.github.com/338782.js?file=setup"></script>

### Usage Examples
<script src="http://gist.github.com/338782.js?file=usage"></script>

## To Do

- Auto-mixin on init
- Choose a better name
- Use shoulda or rspec
- Obtain list of constant values (for use with validations)

Copyright (c) 2010 Jon Morton, released under the MIT license
