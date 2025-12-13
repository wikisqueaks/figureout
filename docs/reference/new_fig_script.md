# Create a new figure script with a unique ID

Create a new figure script with a unique ID

## Usage

``` r
new_fig_script(dir, description, hash_length = 4)
```

## Arguments

- dir:

  Character. Directory in which to create the script file.

- description:

  Character. Short description of the figure produced by the script.

- hash_length:

  Integer. Length of the hash for the unique figure ID.

## Value

Invisibly returns the path to the created script.

## Details

Generates an 8-character alphanumeric ID, shortens the description into
a safe file-name component, and creates a file named: fig-.R The file
contains a single line: the file name as a quoted string.

## Examples

``` r
if (FALSE) { # \dontrun{
create_fig_script("analysis/figures", "retention geometry scaling")
} # }
```
