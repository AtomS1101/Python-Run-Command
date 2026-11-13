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
2. Type `run` to execute it.
3. You can pass arguments as usual. The following two commands are equivalent:
   ```sh
   run file1 file2
   python3 sample.py file1 file2
   ```
The recorded commands will be automatically saved to `python_target_file.txt` in the directory containing `run`.
```tree
.
├── python_target_file.txt   <- HERE
├── run
└── runfile
```
