Using `Sniffnet` to inspect your network activity is a smart step when you want to monitor
traffic. Let's walk through how to **trace strange outgoing connections back to the processes responsible**,
particularly on **Fedora Linux**.

---

## ✅ First: Confirm Your Understanding

### ✔ `wlo1` is likely your **Wi-Fi** interface.

To verify:

```bash
ip link show
```

or

```bash
nmcli device status
```

---

## 📈 Now About the Suspicious Traffic

You mentioned:

- Domains like `*.amazonaws.com`
- Odd ports like `60694`
- Continues **even after Firefox is closed**

That does sound worth investigating, especially if you're not running anything that
should connect to AWS.

---

## 🔍 Step 1: Find Out Which Program Is Sending the Requests

Use one of the following tools:

### 🛠 `ss` or `netstat` to check open connections:

```bash
sudo ss -tupn
```

Output includes:

- Local/remote addresses
- Port
- PID/Program name

Look for `60694` or `amazonaws.com` in the output.

### 🛠 Or better: use `lsof`:

```bash
sudo lsof -i -n -P | grep 60694
```

You'll get the **command, PID, and user** associated with the socket.

---

## 🔁 Step 2: Trace Connections in Real Time

### 🕵️ Option A: Use `nethogs`

Shows **live bandwidth usage by process**:

```bash
sudo nethogs wlo1
```

### 🕵️ Option B: Use `tcpdump` to filter

If you want to see just that traffic:

```bash
sudo tcpdump -i wlo1 port 60694
```

This gives you a raw view, which you can analyze.

---

## 🔐 Step 3: Inspect the PID

Once you have the **PID** from `lsof`, you can inspect more:

```bash
ps -p <PID> -o comm,cmd,user
```

Then you can see:

- What the binary is
- Who is running it
- Command-line args

If you want more:

```bash
sudo ls -l /proc/<PID>/exe
```

---

## ❓Should You Worry?

Not necessarily, but here’s what to check:

### 1. Are you running:

- Dropbox?
- Slack?
- VS Code?
- Anything cloud-based? (they often hit AWS)

### 2. **Try killing** the process and watching Sniffnet to see if the traffic stops:

```bash
kill <PID>
```

If it’s a legit service, it’ll likely restart. If it’s something malicious, that might stop it.

---

## 🧼 Step 4: Scan Your System

You can do a quick check for known malware with:

```bash
sudo dnf install clamav clamav-update
sudo freshclam
sudo clamscan -r /
```

---

## ✅ Conclusion

Here’s your checklist:

| Action                        | Command               |
| ----------------------------- | --------------------- |
| List who owns port            | `sudo lsof -i :60694` |
| Live view per process         | `sudo nethogs wlo1`   |
| Trace suspicious PID          | `ps -p <PID> -o cmd`  |
| Check connection destinations | `sudo ss -tupn`       |
| Kill and observe              | `kill <PID>`          |
| Optional scan                 | `clamscan -r /`       |

---
