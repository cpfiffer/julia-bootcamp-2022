# Julia for Economists
## Parallelization for Fun and Profit
### Cameron Pfiffer (cpfiffer@stanford.edu)

---

## Brief introduction

- I am Cameron Pfiffer, howdy
- Finance PhD student at University of Oregon
- Visiting at the Stanford GSB
- Work mostly on asset pricing, Bayesian econometrics, and computer go-fast stuff

---

## What is this?

- Second in a five-part series on Julia (don't worry if you missed the first)
    3. Optimization and Automatic Differentiation (March)
    4. Performant Programming and Best Practices (April)
    5. Bayesian Inference and Probabilistic Programming (May)
- The focus is programming better for research computing

--- 

## What are we going to do today?

- Learn all about the CPU!
- Multithreading
- Multiprocessing
- GPU parallelism

---

## How are we going to things do today?

- 50 minute lectures.
- 10 minute breaks at the top of the hour, 15 minutes at 11am.
- Interrupt me to ask questions, or type them in the chat
- Intermittent breaks for you to practice some code

---

## Preliminaries

You will need

1. A Julia installation
2. A text editor (VS Code recommended)
3. Your big beautiful brain

If you do not have one of these **please take a moment to go get them**. 

You have a big beautiful brain, don't lie to me about that.

---

## Warning!

I learned a lot of this informally -- parallelization is typically a very dense and technical concept.

I'm going to try my best to give you rigor when I can, but much of this will be a folksy introduction to parallel computing!

---

# Questions, comments, concerns?

---

# The modern central processing unit and how amazing it is

---

## CPUs

You might be aware that there's lots of little bits in your computer that do various kinds of magic.

The CPU is easily one of the most important ones for research computing! And it is full of magic!

---

## CPUs

CPUs are fancy boxes that accept

1. _Instructions_ on what to do (machine code)
2. _Data_ to use for the instructions (numbers, pixels, etc.)

and perform the many requested tasks we ask them to do.

---

## What is inside your CPU?



---

## Serial processing

CPUs at their most basic level do these tasks in *serial*, meaning they do them one at a time.

If we have a long list of things we want done, it will do them _in order_ -- the sixth task is only started after the fifth is done.

---

## Serial processing

If, for example, I ran the following

```julia
x = 0
for i in 1:2
    x = x + i
end
```

we know we'll have `x=3` at the end, but we executed the pseudo-machine code

```julia
x = 0
x = x + 1
x = x + 2
```

This is the order of the code, and it will _always_ be the order of the code.

---

## Serial processing

There's a couple wonderful things about serial processing:

1. It is deterministic (always know what you're going to get)
2. CPUs are super fast at serial processing
3. Lots of complex hidden benefits (easier to cache instructions/data, etc.)

Most things are serial by default. You have to do a bit of work to make things parallel/concurrent!