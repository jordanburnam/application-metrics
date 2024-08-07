# application-metrics
Some python code to put metrics to my job applications. I am also keeping track of who submits the job application which is done by using a google form.

# Prerequisites
```
pip install pipenv
```

# Setup
must run from the project folder
```
pipenv install 
```

# Running 
```
pipenv run python main.py
```

# CSV Structure
| Timestamp            | Company Name | Job Title         | Resume   | Job Link                 | STATUS    | Email Address |
|----------------------|--------------|-------------------|----------|--------------------------|-----------|---------------|
| 2024-06-26 00:00:00  | Google       | CEO               | resumev1 | google.com/job/100       | SUBMITTED | j@b.com       |
| 2024-06-26 02:24:55  | Example      | VP of Engineering | resumev2 | example.com/carreers/100 | SUBMITTED | j@b.com       |
