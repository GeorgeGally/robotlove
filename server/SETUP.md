# Robots Daily Generator — Setup

## Files to copy to server

```bash
scp -r /Users/radarboy3000/Documents/robots/ radarboy@radarboy.com:/home/radarboy/robots/
```

## Server dependencies

```bash
ssh radarboy@radarboy.com
cd /home/radarboy/robots
python3 -m pip install requests python-dotenv
```

## .env file

Create `/home/radarboy/robots/.env`:

```
OPENROUTER_API_KEY=sk-or-v1-your-key-here
```

Set permissions: `chmod 600 /home/radarboy/robots/.env`

## Cron job

```bash
crontab -e
```

Add:

```
0 2 * * * cd /home/radarboy/robots && python3 generate.py >> generate.log 2>&1
```

## First run

```bash
cd /home/radarboy/robots
python3 generate.py
```

Verify:

```bash
cat /home/radarboy/radarboy.com/radarboy3000/robots.txt
cat generate.log
cat memory.md
```
