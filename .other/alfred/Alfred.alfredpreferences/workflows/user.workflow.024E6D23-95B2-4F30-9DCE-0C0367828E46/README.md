#Random String Generator

An Alfred Extension that generates a random string for use in password and such.

[Workflows](https://github.com/jdfwarrior/Workflows) class is written by David Ferguson (many thanks).

##Installation

Download the latest release and install the workflow via Alfred.

## Usage

Type rand and a number to generate a sting. Defaults are letters (uppercase and lowercase) and numbers.

Add an additional second parameter to define the string.

###Options
- u = Use only uppercase letters.
- l = Use only lowercase letters.
- n = Use only numbers.
- nu = No uppercase letters.
- nu = No uppercase letters.
- nu = No uppercase letters.
- c = Crazy (uppercase, lowercase, numbers and _-~!@#$%^><,.)

If none of those options are supplied, but a second parameter is present, the string will generate a key using the defaults and the second parameter. For example, if you wanted underscores, you could type __`rand 20 _`__ to get that result. 