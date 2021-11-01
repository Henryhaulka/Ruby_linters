# Ruby_linters
In this project, I built a Ruby linter that checks for possible errors and hints where such an error occurs in the file.


## Built With

- Ruby

## Function
This is a customized ruby linters that checks a ruby file for the follow possible error/errors:
- Trailing spaces
- Missing/excess 'end' keyword
- Empty Lines
- Wrong Indentation
- Missing/Unexpected tag errors

## Usage
Below are cases for each error
# Trailing space
~~~ruby
#Bad code
class ClassName
  def initialize |
    @name = name |
    @greeting = greeting
  end
end

#Good code
class ClassName
  def initialize
    @name = name
    @greeting = greeting
  end
end

~~~

# Missing/Unexpected tag errors
~~~ruby
#Bad code
class ClassName
  def initialize]
    @name = name)
    @greeting = greeting
  end
end

#Good code
class ClassName
  def initialize
    @name = name
    @greeting = greeting
  end
end

~~~

# Missing/Unexpected 'end' keyword
~~~ruby
#Bad code
class ClassName
  def initialize
    @name = name
    @greeting = greeting
    
end

#Good code
class ClassName
  def initialize
    @name = name
    @greeting = greeting
  end
end

~~~

# Empty/Excess Lines
~~~ruby
#Bad code
class ClassName
  def initialize
    @name = name
    
   
    @greeting = greeting
   
   
   
end

#Good code
class ClassName
  def initialize
    @name = name
    @greeting = greeting
  end
end

~~~

# Wrong Indentation
~~~ruby
#Bad code
class ClassName
  def initialize
        @name = name
      @greeting = greeting
    
end

#Good code
class ClassName
  def initialize
    @name = name
    @greeting = greeting
  end
end

~~~
## Getting Started

- **Clone the repo by running `git clone` https://github.com/Henryhaulka/Ruby_linters/ Or download the zip folder**
- **Run `cd` Ruby_linters in the terminal**
- **Make sure you have ruby installed locally run `ruby -v`**
- **To start the linters run `bin/main.rb ./lib/test.rb` in the terminal**

## Author


👤 **Onu Henry**

- GitHub: [@Henryhaulka](https://github.com/Henryhaulka)
- Twitter: [@ONUHENRY12](https://twitter.com/ONUHENRY12)
- Linkedin: [Henry Onu](https://www.linkedin.com/in/henry-onu-9a15b11b6/)

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

Feel free to check the [issues page](https://github.com/Henryhaulka/Ruby_linters/issues/).

## Show your support

