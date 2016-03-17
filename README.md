# python-template
A template for new Python 3 projects.

## Requirements
- `make`
- `pip`
- `python3`
- `virtualenv`

## Setup
At this point I assume you do not have root access to the machine, but you do have the `make`, `python3` and `pip` commands available in your `${PATH}`.

### Special notes for users at the University of Oslo
Add the following to your`.bashrc` file if you do not have the aforementioned commands.

	PATH=~/.local/bin:/snacks/bin:${PATH}
	
Restart your terminal or issue `source ~/.bashrc` after editing.

### Installing virtualenv
You may skip this step if you have `virtualenv` available already. Otherwise, issue the following command.

	pip install --user virtualenv

## Using the template
The simplest way to use the template is to just fork this repository on GitHub, rename it and clone it to your local machine.
