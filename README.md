# Technical Challenge

>
Test runs on Python 3.7 Robot Framework
###How to deploy test
>
We can use pip and virtualenv to handle dependencies. Dependencies are saved in requirementes.txt
>
To do so, we need
* Python 3.7
* pip
* virtualenv
>
Steps
1. Clone the repository
2. Navigate to the file path, then run deploy.bat
3. The bat file will setup a virtual environment and install dependencies
4. Do it yourself
>virtualenv venv
>
>venv\Scripts\activate
>
>pip install -r requirements.txt
>
>deactivate 

###How to run
Steps
1. Run run-tests.bat
2. The bat file will startup the virtual environment and run the test. Results will be saved in Results folder
3. Do it yourself
> robot -d Results --variable browser:headlessfirefox Tests\mra_grant_test
4. To include tags, use the -i option
5. Tags added so far
* ac (for acceptance criteria)
* smoke
* negative (for negative scenarios)
