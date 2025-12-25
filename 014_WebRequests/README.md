# Install Dependencies
```
sudo apt update
sudo apt install libcurl4-openssl-dev libssl-dev
```

# Creating Virtual Environment
```
$ python3.12 -m venv env
```

# Activate Virtual Environment
```
$ source env/bin/activate
(env) $ pip install --upgrade pip setuptools
(env) $ pip install -r requirements.txt
```

# Deactivate Virtual Environment
```
(env) $ deactivate
```

# Run TestServer
```
python TestServer.py
```

