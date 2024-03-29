# Systemd Deep Dive

Notes taken on this video by LearnLinuxTV: https://youtu.be/Kzpm-rGAXos

[***Table of Contents***](../README.md)

- Intro
- [Basic Commands](02-basic-commands.md)
- [Advanced Stuff](03-advanced-stuff.md)

## Introduction

There are many tools included in `systemd`. It allows you to manage resources, it
is the most common init system. 

An init system is the most important process, it is the first process that 
starts on your system, its job is to schedule all other processes. 

Topics discussed:

- Basic commands:
    - such as: starting, stopping, restarting services, etc.

- More complex aspects of `systemd`, such as:
    - service files
    - directory priority
    - and so on...

What is **Systemd**?

- It's an "init system", it's a type of process (any task that runs in the
  background).
- It's the most important process running on your system, it's the first
  process that runs when you start your Linux instance. For that reason
  init systems are referred to as **PID1** (proccess ID #1).
- Its job is to manage all other processes, or services that run in the
  background. When you start a process, the request to do it is sent to the
  init system, which then starts it up. It works similiarly when you stop,
  reload, and restart a process.

Working with Units:
	
- Units in Systemd refer to resources it's able to manage for you.
- These include services, timers, mounts, automounts, and so on.
- We will focus on services, but it's a good idea to keep in mind that there
  are other types of units.

In summary, units are what `systemd` can manage for you and a service is a
type of unit.
