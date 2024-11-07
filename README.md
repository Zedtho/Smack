Smack automatically blocks unproductive websites - no need to set-up a whitelist/blacklist that is always either too big or small! Smack also adapts
to your current needs dynamically.


## Getting started
With a release:
Download the dist/ folder onto your computer. Open the folder and add your API-key to .env. Now, left-click on Smack and you're good to go!


From source:
1. Clone the project to your favourite directory of choice.
2. Add your Anthropic API-Token to .env.
3. Install dependencies.
4. Customize the starting prompt in smack.py under is_productive.
5. Run the program (e.g. python smack.py) and you're good to go! 



## FAQ
#### How much do the API calls cost?
I've barely gone upwards of 5 cents a day. With time, it will also get more efficient as it gets to know your most frequent (productive and unproductive) websites.

#### It doesn't seem to work for some browsers
Yeah, unfortunately Wayland seems to interfere with the functioning of the program. It does work for Brave. If somebody knows any good tab-reading libraries/utilities for Linux, let me know! (Currently, we use xdotool). 

#### It misclassified something
1. Give a better task prompt when it queries you 
2. Describe yourself in the system message in function is_productive. (Keep it short to keep it cheap!)
3. If it's a specific website with a non-changing title, you can ctrl+f in whiteblacklist.json and change the value to "True", then restart Smack.
4. If the title of the tab changes regularly (e.g. "Lecture 27.09.2024 - VLC Media Player"), add the word (e.g. VLC, or Lecture) to the dictionary in safe_words. You could also add it to the system prompt, though that'll increase your token costs.

#### Is there Windows/Mac support?
Not yet! Windows support should be trivial with PyGetWindow. I have no clue about Mac, though. Perhaps it'll work out of the box due to the common UNIX core.

#### How do you recommend using this?
I'd let it calibrate to you for a day. I set the program to turn on at startup. . Afterwards, for the sake of habit, don't mess with it! 

#### Why don't you just use e.g. Freedom/ColdTurkey etc.?  
I love ColdTurkey! Sadly, I use Linux. Moreover, generic whitelists didn't quite work for me - I loved reading *anything*, so blocking youtube.com made me end up on Wikipedia, blocking Wikipedia on ourworldindata, etc. etc. 

No more of that!

#### What if I want to just have fun on weekends?
Next time you run the program, say so in the prompt!

That said, while it is running, you can't change it. It's a bit like an Ulysses pact (https://en.wikipedia.org/wiki/Ulysses_pact).
