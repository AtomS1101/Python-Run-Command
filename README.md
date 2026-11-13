# Python-Run-Command
This shell script lets you run a Python script just by typing `run`.
It remembers which script to run for each working directory.

This also activates `.venv` if it exists in your directory.

## Setup

1. Save the script as a file named `run` in a directory that is in your `PATH`.
2. Make it executable:
   ```sh
   chmod +x run
   ```
3. Create a symlink named `runfile` that points to `run`:
   ```sh
   ln -s run runfile
   ```
   
## Usage

1. Register the script to run in the current directory:
   ```sh
   runfile sample.py
   ```
   Or you can specify a module with the `-m` option, which is effective when using relative imports.
   ```sh
   runfile -m module.main
   ```

3. Type `run` to execute it. This remembers which file to run, even after moving to a different path.
4. You can pass arguments as usual. The following two commands are equivalent:
   ```sh
   run file1 file2
   python3 sample.py file1 file2
   ```
## Options
Both options only work with `runfile`.
- `-h` : print usage
- `-m` : module file

## Structure
The recorded commands will be automatically saved to `python_target_file.txt` in the directory containing `run`.
Unlike `.DS_Store` on macOS or `.vs` in Visual Studio, this design keeps your project directory clean. 
```tree
.
├── python_target_file.txt   <- HERE
├── run
└── runfile
```

You can manually add paths and commands separated by `:` as shown below.
```
/home/user/project1:/home/user/project1/script.py
/home/user/project2:-m module.main
```
