# Dependencies & Execution Order

[***go back to intro***](./01-intro.md)

- How are units started?
- How do they establish their dependencies?
- What is going to be affected by an action?
- What order do units come in?

Useful resouces:
- systemd manpage (`man systemd`)
- Unix and Linux System Administrator's Handbook

## General Ordering (Dependencies)

Dependencies are NOT explicit ordering. 

### Wants, WantedBy

Weakest dependency: "Please activate together, but no big deal if you don't."

/lib/systemd/system/friendly-recovery.target  
`Wants=friendly-recovery.service`

/lib/systemd/system/motd-news.timer  
`WantedBy=timers.target`

### Requires, RequiredBy

Strong Dependency: "You MUST activate these units together."

/lib/systemd/system/multi-user.target  
`Requires=basic.target`

/lib/systemd/system/systemd-boot-check-no-failures.service  
`RequiredBy=boot-complete.target`

## Explicit Ordering (Execution Order -- what you probably want)

This is what people usually mean when they configure "Require*". 

/lib/systemd/system/console-getty.service  
`Before=getty.target`

`network-online.target` has to be up BEFORE `motd-news.service`.  
/lib/systemd/system/motd-news.service  
`After=network-online.target`

Dependencies leave a lot of leeway for the order `systemd` picks. 

1. `Before` and `After` are things you're going to use the most.
1. When you manage requirements, you should always do it on the things you are
   managing yourself (in the files you created yourself, not system files).
1. Dependencies are not hard ordering requirements. Weakest ones are `Want*`,
   strong ones are `Require*`.

## Others (from USLAH)
- Requisite -  like Requires, but must already be active
- BindsTo - like Requires, but more tightly coupled
- PartOf - like Requires, but only affects starting/stopping (when you need
  multiple services to start or stop simultaneously)
- Conflicts - exclude units from being active simultaneously
