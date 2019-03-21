## LoginAPP
### Getting started

#### Prerequisites

Ruby version: 2.3.1p112
Rails version: 5.1.6.2
MySQL version: 5.7.19
Rspec version: 3.7.2

#### Installing

bundle all gem
```bash
bundle install
```

migrate migration files
```bash
rake db:migrate
```

load db seed for testing
```bash
rake db:seed
```

run this app
```bash
rails s
```
#### Built with
1. [letter_opener_web](https://github.com/fgrehm/letter_opener_web)(we can check all emails on localhost:3000/letter_opener)

### Testing
#### Run test with Rspec

```bash
rake spec
```

