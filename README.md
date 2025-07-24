# 💣 Logic Bomb 

This project is a controlled lab simulation of a **Logic Bomb** a stealthy, post-exploitation payload designed to demonstrate how attackers maintain access and manipulate compromised systems. Developed as part of an Operating Systems and Cybersecurity course, the project focuses on understanding adversarial techniques and system-level behavior in Windows environments.

![Logic Bomb Demo](ss/IMG-20250724-WA0001.jpg)

## 📁 Project Overview

The Logic Bomb simulates how a Windows system might be compromised using multiple post-exploitation techniques:

- **Reverse Shell (PowerShell)** – Establishes a connection from victim to attacker.
  ![Connection](ss/WhatsAppImage2025-07-23at16.27.47_c4871c53.jpg)
  ![Access](ss/WhatsAppImage2025-07-23at16.27.46_f1865e48.jpg)
- **Persistence via Task Scheduler** – Automatically re-executes payloads upon user login.
  ![Persistence](ss/IMG-20250724-WA0005.jpg)
- **Visual Payloads** – Modifies wallpaper, shows message boxes/pop-ups for impact simulation.
- **Spoofed Executable Delivery** – Delivered via phishing, disguised as a legitimate EXE.
    ![Phishing](ss/IMG-20250724-WA0003.jpg)
- **Process Masquerading** – Mimics trusted system processes to evade detection.
   ![Masquerading](ss/IMG-20250724-WA0005.jpg)
- **Windows API Misuse** – Calls native APIs for stealth and evasion.

---

## 🧪 Lab Setup

- **Attacker Machine:** Kali Linux (Virtual Machine)
- **Victim Machine:** Windows 10 (Virtual Machine)

The attack chain was simulated entirely in a lab through email phishing.



