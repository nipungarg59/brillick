# Setting up shell

if using bash, then put this at the end of your **.bashrc** file. 

````
setup()
{
	if [ "$(basename `pwd`)" = "brillick" ] && [ "$(find . -maxdepth 1 -type d -name '.git')"  ] && [ "$(basename `find . -maxdepth 1 -type d -name '.git'`)" = ".git" ]
	then
		source auto.sh
		initial
	fi
}

export PROMPT_COMMAND=setup
````

**.bashrc** will be present at **~/.bashrc**

# Setting up project

1. Add ssh keys to your github account.
2. Clone the project.
3. Move to the project direcotry.
4. If virtualenv is activated then you are good to go.
5. If virtualenv is not activated, then make sure virtulaenv and python 3.5 is installed and follow these steps.
   * virtualenv -p python3 env
   * source env/bin/activate
   * pip install -r requirements.txt

# Running The project
1. python manage.py migrate 
2. python manage.py runserver