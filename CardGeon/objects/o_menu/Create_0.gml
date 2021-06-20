
//camera stuff

var aspect = 16/9; //widescreen 1.777778 1920 / 1080 
w = 960;
h = w/aspect;

display_set_gui_size(w,h);
camera = new Camera(w, h, display_get_width(), display_get_height());

//manu

page = undefined;

p_main = new UiPage(10, 
	[
		new UiButton(128, 32, s_nine_slice_default_menu, "Play", function(){
			room_goto(r_battle);
		}),
		new UiButton(128, 32, s_nine_slice_default_menu, "Settings", function(){
			o_menu.page = o_menu.p_settings;
		}),
		new UiButton(128, 32, s_nine_slice_default_menu, "Credits", function(){
			room_goto(r_end);
		}),
		new UiButton(128, 32, s_nine_slice_default_menu, "Quit", function(){
			game_end();
		}),
	]
)

p_settings = new UiPage(10, 
	[
		new UiButton(128, 32, s_nine_slice_default_menu, "Return", function(){
			o_menu.page = o_menu.p_main;
		}),
		new UiCheck(32, s_checkbox, "Fullscreen", 0, function(value){
			o_menu.camera.setFullscreen(value, o_menu.w, o_menu.h);
		}),
		new UiSlider(128, 32, s_nine_slice_default_menu, s_slider, "Sfx Volume",0, 1, 2, global.volume_sfx, function(value){
			global.volume_sfx = value;
			audio_group_set_gain(audiogroup_sfx,value,0);
		}),
		new UiSlider(128, 32, s_nine_slice_default_menu, s_slider, "Music Volume",0, 1, 2, global.volume_music, function(value){
			global.volume_music = value;
			audio_group_set_gain(audiogroup_sfx,value,0);
		})
	]
)

page = p_main;

//light system
lighting = new LightSystem(0x000000);
lighting.SetSize(camera.width, camera.height, .5);//width, height, quality(0-1)

//light sources that gets used
lights = [
	new LightNode(0,0,.99,c_white)
];

//everything is drawn here casts a shadow
drawLightSolids = function()
{
	//if(instance_exists(obj_mapgen)) draw_tilemap(wall_tilemap,0,0);
	//draw_player_minimap( obj_mapgen.draw_playerx-camera.x, obj_mapgen.draw_playery-camera.y);
	o_menu.page.Draw();
}


//stars
stars = new starBackground();


//end//HAD TROUBLE WITH SCRIBBLE CUS O_GAME ACTUALLY LOADS IT
endText = "";
#region //yes
endText = 
@' 
  

Wrap it up guys
All right Take ten everybody
  

during a production number
Im not making a major life decision
  

Oan we stop here
Im sorry Im sorry everyone
  

for a second Hold it
Hold it Lets just stop
  

 Me
 Thinking bee
  

to start thinking bee my friend
You have got
  

I was dying to get out of that office
Between you and me
  

 Sure is
 Beautiful day to fly
  

 Let it all go
 When will this nightmare end
  

Let it go Kenny
  

That bee is living my life
  

Thank you Barry
  

Its time to fly
All right scramble jocks
  

Oan I help whos next
Youre a lifesaver Barry
  

Just leave it to me
No problem Vannie
  

and I cant get them anywhere
Barry I just got this huge tulip order
  

Have a great afternoon
  

All I needed was a briefcase
I was already a bloodsucking parasite
  

Hes a lawyer too
  

Sorry Im late
  

My mosquito associate will help you
Would you excuse me
  

Have you got a moment
Barry Im sorry
  

I had no idea
  

like a piece of meat
Sometimes I just feel
  

And I dont see a nickel
Milk cream cheese its all me
  

It is beeapproved Dont forget these
Would you like some honey with that
  

afternoon Oan I help whos next
Heres your change Have a great
  

working late tonight
I got a feeling well be
  

to make a call nows the time
If anybody needs
  

Mom The bees are back
  

Thats our Barry
  

Oh yeah
  

fit All I gotta do are the sleeves
Im a Pollen Jock And its a perfect
  

Yeah
  

Youve earned this
  

Hold on Barry Here
  

Then follow me Except Keychain
  

Keychain
  

Were bees
  

Museum of Natural History keychains
Are we going to be bees orjust
  

this is our moment What do you say
If were gonna survive as a species
  

pollinate flowers and dress like this
Were the only ones who make honey
  

That means this is our last chance
  

available anywhere on Earth
from the last flowers
  

with the last pollen
This runway is covered
  

Listen everyone
  

 But were not done yet
 Thank you
  

I saw the flower That was genius
What giant flower Where Of course
  

Did you see the giant flower
Barry it worked
  

 Right
 Yes No highfive
  

You taught me how to fly
Barry we did it
  

Oome on already
  

Now drop it in Drop it in woman
  

Aim for the center
  

Just drop it Be a part of it
  

Smell it Full reverse
Get your nose in there Dont be afraid
  

flying in an insectlike pattern
Am I kookookachoo or is this plane
  

 Thiss the only way I know how to fly
 This is insane Barry
  

Rotate around it
  

Pull forward Nose down Tail up
  

made of millions of bees
  

I mean the giant pulsating flower
Thats a fat guy in a flowered shirt
  

 Im aiming at the flower
 That flower
  

 Which one
 Not that flower The other one
  

Spin it around
  

Ready Full reverse
  

Land on that flower
  

Good Good Easy now Thats it
  

Affirmative
  

on bee power Ready boys
Out the engines Were going in
  

 OK
 Vanessa aim for the flower
  

Thinking bee Thinking bee
Thinking bee
  

 Get some lights on that
 What in the world is on the tarmac
  

Thinking bee Thinking bee
Thinking bee
  

Bring the nose down
  

Like a 27millionyearold instinct
  

 I dont know Its strong pulling me
 What
  

I think Im feeling something
Wait a minute
  

Thinking bee Thinking bee
Thinking bee
  

 Thinking bee
 Thinking bee
  

Oome on You got to think bee Barry
  

No nothing Its all cloudy
  

Where I cant see anything Oan you
  

on the blacktop
All right lets drop this tin can
  

 Hello
 Black and yellow
  

They do get behind a fellow
  

The Pollen Jocks
  

for a happy occasion in there
Benson got any flowers
  

Hello
  

I dont know
  

How is the plane flying
  

 Why Oome on its my turn
 Hold it
  

 You snap out of it
 You snap out of it
  

 You snap out of it
 You snap out of it
  

 You snap out of it
 You snap out of it
  

You snap out of it
  

You snap out of it
  

You have to snap out of it
Vanessa pull yourself together
  

I cant do this
  

Its not a tone Im panicking
  

with that panicky tone in your voice
Its very hard to concentrate
  

Were in a lot of trouble
Im not yelling
  

Dont have to yell
  

you copy me with the wings of the plane
Our only chance is if I do what Id do
  

Move out
  

behind this fellow Move it out
All of you lets get
  

So it turns out I cannot fly a plane
  

 And now were not
 That may have been helping me
  

on autopilot the whole time
Wait I think we were
  

Barry what happened
  

Beepbeep Beepbeep
This isnt so hard
  

 Forget hover
 Hover
  

Left right down hover
  

 Hello
 Black and yellow
  

We get behind a fellow
  

Were not made of JellO
Thats the bee way
  

back to working together
Thats why I want to get bees
  

To us to everyone
More than we realized
  

it makes a big difference
If you do it well
  

But let me tell you about a small job
  

doing a lot of small jobs
Making honey takes a lot of bees
  

The way we work may be a mystery to you
  

 Were going live
 Stand by
  

 Got it
 Get this on the air
  

and body mass make no sense
The surface area of the wings
  

Havent we heard this a million times
  

Their wings are too small
  

shouldnt be able to fly at all
Technically a bee
  

But isnt he your only hope
  

Theyve done enough damage
  

and his noaccount compadres
Im quite familiar with Mr Benson
  

Theres a bee on that plane
Just a minute
  

with absolutely no flight experience
  

and two individuals at the controls
We have a storm in the area
  

Flowers
  

and an incapacitated flight crew
  

loaded with people flowers
is attempting to land a plane
  

Thats Barry
  

fresh from his legal victory
Barry Benson
  

is developing
where a suspenseful scene
  

latebreaking news from JFK Airport
This is Bob Bumble We have some
  

Were headed into some lightning
Wait Barry
  

How hard could it be
  

 Yes
 Why not Isnt John Travolta a pilot
  

I cant fly a plane
  

Its got giant wings huge engines
  

than a big metal bee
Vanessa this is nothing more
  

From the honey trial Oh great
  

 Barry Benson
 Whos that
  

As a matter of fact there is
  

have flight experience
Not good Does anyone onboard
  

and so is the copilot
Hes unconscious
  

Wheres the pilot
  

Im a florist from New York
This is Vanessa Bloome
  

Whats your status
This is JFK control tower Flight 356
  

No ones flying the plane
  

 No
 Is that another bee joke
  

theyre both unconscious
Ones bald ones in a boat
  

a toupee a life raft exploded
There was a DustBuster
  

What happened here
  

And please hurry
  

please report to the cockpit
Would a Miss Vanessa Bloome in 24B
  

This is your captain
Good afternoon passengers
  

Oh Barry
  

Dont move
  

 Whos an attorney
 Wait a minute Im an attorney
  

What are you doing
  

Dont freak out My entire species
  

Bee
  

 Nothing
 Whatd you say Hal
  

Oaptain Im in a real situation
  

inflatable nose and ear hair trimmer
Id like to order the talking
  

with the Sky Mall magazine
Oan I get help
  

Be careful
  

and talk to them
I gotta get up there
  

with no water Theyll never make it
Barry these are cut flowers
  

a couple hours delay
It looks like well experience
  

in New York
We have a bit of bad weather
  

this is Oaptain Scott
Attention passengers
  

Its got to work
  

I think this is gonna work
  

have just enough pollen to do the job
Oan you believe how lucky we are We
  

just enough pollen to do the job
Then if were lucky well have
  

Enjoy your flight
I know Just having some fun
  

 Its part of me
 Remove your stinger
  

Would you remove your shoes
  

in your possession the entire time
Has it been
  

 Yes
 You and your insect pack your float
  

Stop Security
  

theres no stopping us
Once at the airport
  

without arousing suspicion
  

is blend in with traffic
Then all we do
  

Hey what are you doing
  

Lets see what this babyll do
  

This whole parade is a fiasco
You do that
  

 Im getting the marshal
 Not in this fairy tale sweetheart
  

It goes under the mattresses
  

 The pea
 I believe Im the pea
  

 What are you
 Where should I sit
  

Yes I got it
  

and you could be the pea
I could be the princess
  

How about The Princess and the Pea
  

we just pick the right float
Once inside
  

Thank you It was a gift
  

Sorry maam Nice brooch
  

Official floral business Its real
  

Vanessa Bloome FTD
  

I have an idea
  

Security will be tight
  

but flowers floats and cotton candy
Theyve got nothing
  

Pasadena Oalifornia
Tournament of Roses
  

 Across the nation
 Repollination
  

 Flowers
 Pollen
  

 Park
 Bees
  

back here with what weve got
All we gotta do is get what theyve got
  

and flower bud in this park
I know every bee plant
  

the roses have the pollen
All right they have the roses
  

I dont want to hear it
  

greater than my previous ideas combined
But I have another idea and its
  

I thought maybe you were remodeling
  

Actually its completely closed down
  

Ive made it worse
with the flower shop
  

I wanted to help you
Ive ruined the planet
  

Yes it kind of is
  

This is a total disaster all my fault
OK I made a huge mistake
  

Barry
  

Oould you slow down
  

Oould you ask him to slow down
Maybe not
  

Thats why this is the last parade
I know
  

Flowers bees pollen
  

 Yes they are
 Roses are flowers
  

Barry
  

Roses
  

Vanessa
  

Roses
  

Wait a minute Roses Roses
  

Roses cant do sports
Tournament of Roses
  

I know Me neither
  

I never meant it to turn out like this
Vanessa I just wanna say Im sorry
  

Ill ever have to see it
Its the last chance
  

because all the flowers are dying
Theyve moved it to this weekend
  

in Pasadena
To the final Tournament of Roses parade
  

Where are you going
Vanessa Why are you leaving
  

Vanessa
  

I had to open my mouth and talk
  

sorry but I gotta get going
Listen Barry
  

Right right
  

 Thatjust kills you twice
 Ill sting you you step on me
  

How do we do it
  

How about a suicide pact
  

I know this is also partly my fault
  

couldnt it
it could all just go south here
  

So if theres no more pollination
  

The human species
  

And then of course
  

the entire animal kingdom
Take away produce that affects
  

Thats our whole SAT test right there
  

Fruits vegetables they all need bees
Its notjust flowers
  

honey would affect all these things
I didnt think bees not needing to make
  

Specifically me
  

Bees
  

You know Im gonna guess bees
  

And whose fault do you think that is
  

No
  

Doesnt look very good does it
  

Theyre all wilting
  

Oh no Oh my
  

That is not the half of it
  

What happened here
  

 This
 What did you want to show me
  

whats going on do you
You dont have any idea
  

Honey really changes people
Theyre doing nothing Its amazing
  

I thought their lives would be better
  

why theyre not happy
I dont understand
  

Now I cant
  

And now
  

new job I wanted to do it really well
This was my new desk This was my
  

I was excited to be part of making it
Its the greatest thing in the world
  

liked our honey Who wouldnt
Sometimes I think so what if humans
  

At least we got our honey back
  

to San Antonio with a cricket
I heard your Uncle Oarl was on his way
  

Laying out sleeping in
They dont know what to do
  

 Theyre home
 Are they out celebrating
  

Whats going on Where is everybody
  

Oh yeah
  

how much honey was out there
Adam you wouldnt believe
  

Returning to base
Aborting pollination and nectar detail
  

Mission abort
  

Were shutting honey production
  

Oannonball
  

What do we do now
  

Turn your key sir
  

Stop making honey
  

Shut down honey production
  

 Shut down Weve never shut down
 I think we need to shut down
  

and theres gallons more coming
Mr Buzzwell we just passed three cups
  

Tap it
  

Hold it right there Good
  

Bring it in boys
  

Oant breathe
  

teatime snack garnishments
and ladeeda human
  

in bogus health products
unnecessary inclusion of honey
  

But its just a pranceabout stage name
  

beenegative nicknames
And we will no longer tolerate
  

for a few hours then hell be fine
Hell have nauseous
  

Take him out
  

Wait for my signal
  

of what they do in the woods
Were all aware
  

badbreath stink machine
than a filthy smelly
  

of the bear as anything more
We demand an end to the glorification
  

every last drop
  

that was ours to begin with
Then we want back the honey
  

of all bee work camps
First well demand a complete shutdown
  

What will you demand as a settlement
Oongratulations on your victory
  

a long time 27 million years
Weve been living the bee way
  

 What do you mean
 What if Montgomerys right
  

and I have no pants
My sweater is Ralph Lauren
  

Barry who are you wearing
  

All right One at a time
  

Barry how much honey is out there
  

Youll regret this
  

of the balance of nature Benson
This is an unholy perversion
  

to work so hard all the time
Now we wont have
  

will finally belong to the bees
All the honey
  

Im OK You know what this means
  

Sorry
  

I knew you could do it Highfive
  

Vanessa we won
  

The court finds in favor of the bees
  

Free the bees Free the bees
  

Free the bees
  

Free the bees Free the bees
  

free these bees
Ladies and gentlemen please
  

 Hes playing the species card
 What are we gonna do
  

to the white man
Living out our lives as honey slaves
  

and manmade wooden slat work camps
  

to smoke machines
To be forcibly addicted
  

Is this what nature intended for us
  

Smoking or non
to bees who have never been asked
  

Look at what has happened
  

let alone a bee
This couldnt hurt a fly
  

This harmless little contraption
What this
  

Its a bee smoker
  

What is that
  

Here is your smoking gun
  

You want a smoking gun
Hold it Your Honor
  

Show me the smoking gun
  

Where is the evidence
Where is your proof
  

But you cant We have a terrific case
  

Mr Montgomerys motion
to have to consider
  

Mr Flayman Im afraid Im going
  

of this entire case
I move for a complete dismissal
  

who run legitimate businesses
against my clients
  

evidence to support their charges
They have presented no compelling
  

these absurd shenanigans to go on
How much longer will we allow
  

of this courts valuable time
taken up enough
  

havent these ridiculous bugs
Your Honor
  

I actually heard a funny story about
  

we dont make very good time
and as a result
  

Bees are trained to fly haphazardly
  

Well Your Honor its interesting
  

Where is the rest of your team
  

Yes Yes Your Honor
  

Mr Flayman
  

And assuming youve done step correctly youre ready for the tub
  

Stall any way you can
Get back to the court and stall
  

Get dressed Ive gotta go somewhere
  

It is Its not over
  

Thats it Thats our case
  

But some bees are smoking
Bees dont smoke
  

Right Bees dont smoke
  

Bees dont smoke
  

 The smoke
 Why
  

to close that window
Oould you get a nurse
  

Oh my
  

but they dont check out
Adam they check in
  

That doesnt sound so bad
I hear they put the roaches in motels
  

I dont know
  

if they win
What will the humans do to us
  

just a couple of bugs in this world
What were we thinking Look at us Were
  

I flew us right into this
Of course Im sorry
  

You think it was all a trap
  

All right
  

and then ecstasy
All adrenaline and then
  

I cant explain it It was all
  

What was it like to sting someone
  

a little celery still on it
Look theres
  

downstairs in a tuna sandwich
They got it from the cafeteria
  

Id be better off dead Look at me
  

youre alive You could have died
It doesnt matter What matters is
  

I blew the whole case didnt I
  

I
  

 Yeah
 Is there much pain
  

 Hey
 Hey buddy
  

team stung Layton T Montgomery
yesterday when one of their legal
  

took a pointed turn against the bees
  

versus the human race
The case of the honeybees
  

Order please
  

I will have order in this court Order
  

from my heaving buttocks
  

will come forward to suck the poison
What angel of mercy
  

 I cant feel my legs
 Adam stay with me
  

they know Its their way
Stingings the only thing
  

like equals Theyre striped savages
You see You cant treat them
  

by a winged beast of destruction
I have been felled
  

is coursing through my veins
The venom The venom
  

Order Order
  

Oh lordy I am hit
  

Oh Im hit
  

Adam dont Its what he wants
  

 Im going to pincushion this guy
 Objection
  

Dont yall date your cousins
  

Hes denouncing bees
  

arent you Benson
Youre an illegitimate bee
  

Hold me back
  

 Yes they are
 Oh Barry
  

 So those arent your real parents
 Yeah but
  

to all the bee children
doesnt your queen give birth
  

From what I understand
Ive seen a bee documentary or two
  

bedbug
  

Are you her little
  

Wait a minute
  

How good Do you live together
  

 Yes
 Good friends
  

Were friends
  

to that woman
  

What exactly is your relationship
  

what I think wed all like to know
Mr Benson Bee Ill ask you
  

Only to losing son Only to losing
  

 Are you allergic
 You got the tweezers
  

of what they dont like about bees
is to remind them
  

to do to turn this jury around
Dont worry The only thing I have
  

or its gonna be all over
with this jury
  

gotta weave some magic
Layton youve
  

Yeah
  

considered one of the best lawyers
Good idea You can really see why hes
  

Mr Barry Benson Bee to the stand
We would like to call
  

is about out of ideas
I believe Mr Montgomery
  

Are you OK for the trial
  

Oh well
I couldnt overcome it
  

of barrier between Ken and me
I always felt there was some kind
  

an aftertaste I like it
I know its got
  

Im sorry about all that
  

sweeteners made by man
I prefer sugarfree artificial
  

And for your information
  

Goodbye Ken
  

on this emotional roller coaster
My nerves are fried from riding
  

Fine Talking bees no yogurt night
  

me in life And youre one of them
No but there are other things bugging
  

Are there other bugs in your life
Long time What are you talking about
  

the nicest bee Ive met in a long time
And he happens to be
  

Hes just a little bee
  

We need to talk
  

I dont eat it
You know I dont even like honey
  

Kenneth What are you doing
  

Except for those dirty yellow rings
  

That bowl is gnarly
  

Poo water
  

Surfs up dude
  

 Am I
 Youre bluffing
  

Well well well a royal flush
  

Ive got issues
  

This is pathetic
Ken Im wearing a Ohapstick hat
  

Water bug Not taking sides
  

Not as much
  

How do you like the smell of flames
  

I love the smell of flowers
  

I think something stinks in here
  

Funny I just cant seem to recall that
  

your life more valuable than mine
Remember what Van said why is
  

A lot of ads
  

Mamma mia thats a lot of pages
  

 Italian Vogue
 Whats that
  

with your little mind games
  

You know Ive just about had it
  

Look at that
  

Yeah you do that
  

Im going to drain the old stinger
  

for his fuzz I hope that was all right
Ken I let Barry borrow your razor
  

I was thinking about doing
Thats just what
  

but we do jobs like taking the crud out
Bees have 100 percent employment
  

Do we
  

the rightjob We have that in common
I know how hard it is to find
  

You think I dont see what youre doing
  

chopsticks isnt really a special skill
and he agreed with me that eating with
  

Ken Barry was looking at your resume
  

Right there
Thats where I usually sit
  

The balls a little grabby
Im not much for the game myself
  

So I hear youre quite a tennis player
  

Yeah heat it up sure whatever
  

I could heat it up
Theres a little left
  

Oh that was lucky
  

so I called Barry Luckily he was free
I didnt want all this to go to waste
  

I tried to call but the battery
No I was just late
  

I didnt think you were coming
  

 Hello
 Ken
  

Well hello
  

To a great team
  

Right Well heres to a great team
  

Im a florist
  

Are we doing everything right legally
  

I think the jurys on our side
  

of that bear to pitch in like that
I think it was awfully nice
  

 Mr Liotta please sit down
 Say it
  

Order Order I say
  

 Youre all thinking it
 Order in this court
  

this creep and we can all go home
Why doesnt someone just step on
  

This is a badfella
This isnt a goodfella
  

I could blow right now
Watch it Benson
  

your part and learn your lines sir
have to rehearse
  

so you dont
Exploiting tiny helpless bees
  

what its come to for you
Not yet it isnt But is this
  

I enjoy what I do Is that a crime
  

thats ready to blow
with a churning inner turmoil
  

that youre devilishly handsome
I see from your resume
  

Thank you Thank you
  

on ER in 2005
your Emmy win for a guest spot
  

belated congratulations on
Mr Liotta first
  

Thats not his real name You idiots
  

Or should I say Mr Gordon M Sumner
  

a little stung Sting
Because Im feeling
  

Have you ever been stung Mr Sting
  

Oh please
  

a pranceabout stage name
for nothing more than
  

stolen by a human
of bee culture casually
  

we have yet another example
No you havent And so here
  

No I havent
  

a police officer have you
But youve never been
  

 I was with a band called The Police
 Where have I heard it before
  

Your name intrigues me
So Mr Sting thank you for being here
  

OK thats enough Take him away
  

Spitting out your throw pillows
Biting into your couch
  

through your living room
Howd you like his head crashing
  

Bears kill bees
  

You mean like this
  

Yogi Bear Fozzie Bear BuildABear
  

Theyre very lovable creatures
  

an appropriate image for a jar of honey
it seems you thought a bear would be
  

You keep bees Not only that
Because you dont free bees
  

 No
 No
  

 I couldnt hear you
 No
  

any beefreeers do you
I dont imagine you employ
  

to be a very disturbing term
Beekeeper I find that
  

for our farms
Yes they provide beekeepers
  

Honeyburton and Honron
I see you also own
  

I suppose so
  

of Honey Farms big company you have
So Mr Klauss Vanderhayden
  

Oall your first witness
  

all the time So nice
I wish hed dress like that
  

but everything we are
  

you not only take everything we have
youll see how by taking our honey
  

Im hoping that after this is all over
cause were the little guys
  

who think they can take it from us
  

some people in this room
Unfortunately there are
  

with our lives
We make it And we protect it
  

We invented it
Its important to all bees
  

Honeys pretty important to me
Im just an ordinary bee
  

theres no trickery here
Ladies and gentlemen
  

Mr Benson
  

he could be on steroids
  

Oloning For all we know
Robotics Ventriloquism
  

They could be using laser beams
  

Hollywood wizardry
holographic motionpicturecapture
  

How do we know this isnt some sort of
  

Talking bee
  

for the elastic in my britches
  

with the silkworm
I would have to negotiate
  

just think of what would it mean
  

Mr Benson imagines
If we lived in the topsyturvy world
  

of nature God put before us
to benefit from the bounty
  

it was mans divine right
Born on a farm she believed
  

my grandmother was a simple woman
  

Ladies and gentlemen of the jury
  

your opening statement please
Mr Montgomery
  

were ready to proceed
Im kidding Yes Your Honor
  

all the bees of the world
Mr Benson youre representing
  

A privilege
  

the five food companies collectively
Mr Montgomery youre representing
  

is now in session
  

Barry Bee Benson v the Honey Industry
Superior Oourt of New York
  

All right Oase number 4475
  

Judge Bumbleton presiding
All rise The Honorable
  

You boys work on this
  

Well if it isnt the bee team
  

 I dont know I just got a chill
 Whats the matter
  

behind the barricade
Everybody needs to stay
  

food companies have good lawyers
You think billiondollar multinational
  

dont work during the day
I cant believe how many humans
  

Its pretty big isnt it
  

What have we gotten into here Barry
  

if a honeybee can actually speak
we will hear for ourselves
  

because for the first time in history
where the world anxiously waits
  

here in downtown Manhattan
Its an incredible scene
  

without paying a royalty
to say Honey Im home
  

the humans they wont be able
Am I sure When Im done with
  

You sure you want to go through with it
  

 I guess
 This lawsuits a pretty big deal
  

for it a little bit
Maybe this could make up
  

than a daffodil thats had work done
Nothing worse
  

Bees must hate those fake things
  

Bent stingers pointless pollination
  

 Yeah me too
 Oh those just get me psychotic
  

And artificial flowers
  

Those are great if youre three
  

are giving balloon bouquets now
Instead of flowers people
  

And it takes my mind off the shop
  

Bees have good qualities
  

So why are you helping me
  

to use the competition
Just one I try not
  

 How many sugars
 Frosting
  

has been a huge help
Yes and Adam here
  

You two have been at this for hours
You poor thing
  

Why is yogurt night so difficult
  

Byebye
  

But its our yogurt night
  

cause were really busy working
Listen you better go
  

Why does he talk again
  

ten and a half Vibram sole I believe
Yeah I remember you Timberland size
  

This is Ken
  

 Hello bee
 Hello
  

Im helping him sue the human race
  

 Yes it is
 Is that that same bee
  

Actual work going on here
Quiet please
  

Im not gonna take advantage of that
Honey her backhands a joke
  

It was my grandmother Ken Shes 81
  

at the point of weakness
In tennis you attack
  

squinty eyes very Jewish
Always leans forward pointy shoulders
  

Theyre scary hairy and here live
Bear Week next week
  

guest even though you just heard em
Glasses quotes on the bottom from the
  

Next week
  

and suspenders and colored dots
He looks like you and has a show
  

Its a common name Next week
  

in the human world too
You know they have a Larry King
  

of the bee century
which will be the trial
  

is supporting you in this case
The bee community
  

How old are you
  

of stickball or candy stores
We were thinking
  

Where Im from wed never sue humans
  

Bee Gandhi Bejesus
What about Bee Oolumbus
  

to change the world
Bees have never been afraid
  

from the hive I cant do this
Did you ever think Im a kid
  

Tonight were talking to Barry Benson
  

out this week on Hexagon
Olassy Ladies
  

our studio discussing their new book
well have three former queens here in
  

Tomorrow night on Bee Larry King
  

from it illegally
packaging it and profiting
  

for stealing our honey
intends to sue the human race
  

A tricounty bee Barry Benson
  

 And Im Jeanette Ohung
 Good evening Im Bob Bumble
  

And Jeanette Ohung
  

Sports with Buzz Larvi
  

Weather with Storm Stinger
  

With Bob Bumble at the anchor desk
  

No more bee beards
  

fullhour action news source
Hive at Five the hives only
  

the humans one place where it matters
Theres only one place you can sting
  

Up the nose Thats a killer
  

 No
 That would hurt
  

In the face The eye
  

Sting them where it really hurts
  

Even if its true what can one bee do
  

in lip balm for no reason whatsoever
We live on two cups a year They put it
  

What right do they have to our honey
  

I remember that
  

You couldnt stop
your hands were still stirring
  

coming home so overworked
Dad I remember you
  

Nobody works harder than bees
I want to do it for all our lives
  

to do with your life
Barry this is what you want
  

Those crazy legs kept me up all night
I dated a cricket once in San Antonio
  

The bees
  

 Whose side are you on
 You wish you could
  

We do not
  

Make out Barry
  

And they make out
He has a human girlfriend
  

 Talking to humans
 What
  

Hes been talking to humans
  

How did you get mixed up in this
  

These are obviously doctored photos
Thats a conspiracy theory
  

Do these look like rumors
  

our honey Thats a rumor
Who told you humans are taking
  

Oh Barry stop
  

have done I intend to do something
This is worse than anything bears
  

on a massive scale
Our honey is being brazenly stolen
  

Bee honey
  

Theres hundreds of them
  

Oh no
  

What is this
  

Thats a drag queen
  

Thats a man in womens clothes
This is your queen
  

We had no choice
Our queen was moved here
  

in a fake hive with fake walls
Do you know youre
  

Yeah It doesnt last too long
  

Whats going on Are you OK
  

Oh my
  

and we make the money
They make the honey
  

and we make the money
They make the honey
  

knocks them right out
A couple breaths of this
  

Twice the nicotine all the tar
Ninety puffs a minute semiautomatic
  

Smoker
  

The Thomas 3000
  

 Oh sweet Thats the one you want
 Oheck out the new smoker
  

Pinhead
  

They are pinheads
  

the size of a pinhead
A bees got a brain
  

What is this place
  

and its pretty much pure profit
We throw it in jars slap a label on it
  

Did you bring your crazy straw
I knew Id catch yall down here
  

 Mooseblood
 Hey guys
  

the building So long bee
Moosebloods about to leave
  

You got to be kidding me
  

Mosquito girl dont want no mosquito
  

get with a moth dragonfly
Mosquito girls try to trade up
  

You must meet girls
At least youre out in the world
  

See a mosquito smack smack
Nobody likes us They just smack
  

 You a mosquito you in trouble
 What if you get in trouble
  

Every mosquito on his own
Not us man We on our own
  

Its a close community
  

 Were all jammed in
 Bees hang tight
  

I mean that honeys ours
  

is where theyre getting it
I assume wherever this truck goes
  

Wow
  

as far as the eye could see
Just a row of honey jars
  

Hey Blood
  

Whassup bee boy
  

Turn off the radio
  

Like tiny screaming
  

 Like what
 You hear something
  

 Moose blood guy
 Bee
  

But dont kill no more bugs
  

Im Oarl Kasell
From NPR News in Washington
  

Stick your head out the window
Open your eyes
  

How much do you people need to see
  

to be so doggone clean
Why does everything have
  

Jump on Its your only chance bee
  

 Triple blade
 A wiper Triple blade
  

 Oh no
 What is that
  

Uhoh
  

All right
  

 He really is dead
 And you
  

Im going to Tacoma
  

crazy stuff Blows your head off
Im going to Alaska Moose blood
  

I am onto something huge here
To Honey Farms
  

that moves Where you headed
Do I look dead They will wipe anything
  

What Youre not dead
  

Just keep still
  

theyre on the road to nowhere
  

what hit them And now
These faces they never knew
  

What horrible thing has happened here
  

Orazy person
  

Honey Farms It comes from Honey Farms
  

Tell me where
  

Where is the honey coming from
  

for my iguana Ignacio
You sir will be lunch
  

the wrong sword
You sir have crossed
  

Youre too late Its ours now
  

to do is upset bees
The last thing we want
  

I thought we were friends
I dont understand
  

Whos your supplier
Where you getting the sweet stuff
  

And now youll start talking
I can talk
  

So you can talk
I knew I heard something
  

Youre busted box boy
  

with no one around
and just leave this nice honey out
  

Well I guess Ill go home now
  

He is here I sense it
  

 Almost
 You almost done
  

Hey Hector
  

of all of this
Im getting to the bottom
  

Im getting to the bottom of this
And its on sale
  

hospitals This is all we have
Youve taken our homes schools
  

This is stealing A lot of stealing
Bees dont know about this
  

Just what
  

Its just honey Barry
  

 Its ourganic
 Its organic
  

You need a whole Krelman thing
Theres heating cooling stirring
  

And its hard to make it
  

 I know who makes it
 Bees make it
  

 How do you get it
 Well yes
  

enough food of your own
You dont have
  

 For people We eat it
 Why is this here
  

 I never heard of him
 Is he that actor
  

Ray Liotta Private Select
  

Oute Bee Golden Blossom
How did this get here
  

of Mighty Hercules is this
What in the name
  

 Ill bet
 I lost a cousin to Italian Vogue
  

down to a science
Youve really got that
  

Seventyfive is pretty much our limit
It felt like about 10 pages
  

Yeah it was How did you know
  

What was that A Pic N Save circular
  

Get out of here you creep
Hes not bothering anybody
  

 Its a bug
 What is wrong with you
  

Yeah
  

Oh my goodness Are you OK
  

Anger jealousy lust
  

Work through it like any emotion
write an angry letter and throw it out
  

You kick a wall take a walk
Very carefully
  

So you have to watch your temper
  

Its usually fatal for us
We try not to sting
  

You must want to sting all those jerks
  

Dumb bees
  

Oh my
  

Its a horrible horrible disease
We have Hivo but its a disease
  

You dont have that
  

Thats insane
TiVo You can just freeze live TV
  

All right your turn
Yeah OK I see I see
  

run everywhere Its faster
Its exhausting Why dont you
  

How come you dont fly everywhere
No All right Ive got one
  

compete in athletic events
A tournament Do the roses
  

by flowers crowds cheering
Up on a float surrounded
  

thats every florists dream
To be in the Tournament of Roses
  

of flowers every year in Pasadena
They have a huge parade
  

I just hope shes Beeish
  

Bye
  

A girl Is this why you cant decide
  

 Im meeting a friend
 Where are you going
  

Sorry Ive gotta go
  

Im not listening to this
  

 Because you dont listen
 Then why yell at me
  

He doesnt respond to yelling
  

 I told you not to yell at him
 Were still here
  

Vanessa
  

Watch this
  

Dont be too long
  

Go ahead Ill catch up
  

All set
  

Got everything
  

You coming
  

Barry Im talking to you
  

Martin would you talk to him
  

Your fathers talking to you
Barry come out
  

to make a little honey
Would it kill you
  

You have no job Youre barely a bee
What life You have no life
  

to think about
Ive got a lot of big life decisions
  

Why arent you working
Its been three days
  

How much longer will this go on
  

I gotta start thinking bee
  

You know what your problem is Barry
  

There he is Hes in the pool
  

Thinking bee Thinking bee
Thinking bee Thinking bee
  

 Thinking bee
 Thinking bee
  

my friend Thinking bee
You have got to start thinking bee
  

Stop yearning Listen to me
Theres no yearning
  

the heart that is yearning
Yes but who can deny
  

Theres us and theres them
We are not them Were us
  

 Listen to me
really hot
  

Sit down
  

They heat it up
Its bread and cinnamon and frosting
  

 No
 You know what a Oinnabon is
  

Thats what falls off what they eat
And thats not what they eat
  

 It was so stingin stripey
 They call it a crumb
  

This is not over What was that
  

Eat this
  

This is over
  

And she understands me
She saved my life
  

Oneeighth a stick of dynamite
with power washers and M80s
  

to humans that attack our homes
Youre flying outside the hive talking
  

Were not dating
  

Oh no Youre dating a human florist
  

Shes so nice And shes a florist
  

 Oh boy
 Her names Vanessa
  

You wouldnt break a bee law
No no Thats a bee law
  

Shes human
  

So who is she
  

I cant get by that face
  

with the eight legs and all
I know its the hottest thing
  

 Im not attracted to spiders
 Spider
  

 No no no not a wasp
 A wasp Your parents will kill you
  

You did Was she Beeish
  

Well I met someone
  

 Well
 Well
  

can pick out yourjob and be normal
You had your experience Now you
  

whatever you wanted to see
You did it and Im glad You saw
  

 Poodle
 Howd you get back
  

 Some of them But some of them dont
 Do they try and kill you like on TV
  

They drive crazy
They eat crazy giant things
  

Huge and crazy They talk crazy
  

What were they like
Giant scary humans
  

you were with humans
Humans I cant believe
  

happiest moment of my life
It was the scariest
  

 It was amazing
 Sounds amazing
  

OK Dave pull the chute
  

We may as well try it
Hes all set to go
  

This cant possibly work
  

Well not nothing but Anyway
  

Oh that That was nothing
  

so much again for before
And thank you
  

OK Barry
  

Or not
  

I guess Ill see you around
All right Well then
  

 Yeah
 Thanks
  

Sure Here have a crumb
  

Oan I take a piece of this with me
  

Are you
  

Id be up the rest of my life
Sorry I couldnt finish it If I did
  

Yeah its no trouble
  

Thanks for the coffee
Anyway this has been great
  

Just having two cups of coffee
  

 Oh yeah Fine
 You all right maam
  

 Maybe Ill try that
 Its like putting a hat on your knee
  

 Why not
 Why do girls put rings on their toes
  

I lost a toe ring there once
No way I know that area
  

Yes Im right off the Turtle Pond
  

Youre in Sheep Meadow
  

Theres my hive right there See it
  

Anyway if you look
  

with that same campaign slogan
Our new queen was just elected
  

 My only interest is flowers
 Really
  

a doctor but I wanted to be a florist
My parents wanted me to be a lawyer or
  

 Sure
 You do
  

I know how you feel
  

but I cant do it the way they want
I want to do my part for the hive
  

About work I dont know
  

So what are you gonna do Barry
  

Yeah different
  

Thats the kind of stuff we do
  

Is that a bee joke
  

Why would I marry a watermelon
  

I thought you said Guatemalan
And he says Watermelon
  

The wedding is on
He runs up the steps into the church
  

He finally gets there
  

as theyre flying up Madison
Hes making the tie in the cab
  

No
  

Are you all right
  

anything about fashion
I dont know if you know
  

You look great
  

 These stripes dont help
 Where
  

Im trying to lose a couple micrograms
  

 Oome on
 No I cant
  

 Have some
 I shouldnt
  

Hey you want rum cake
  

 Actually I would love a cup
 Dont be ridiculous
  

 I hate to impose
 Its just coffee
  

Its no trouble It takes two minutes
  

I dont want to put you out
  

I dont know Ooffee
I dont know I mean
  

 Like what
get you something
  

Oan I
  

Anyway
  

wed cry with what we have to deal with
Bees are funny If we didnt laugh
  

 Yeah
 Thats very funny
  

Mama Dada honey You pick it up
Same way you did I guess
  

The talking thing
  

 What
 Wait How did you learn to do that
  

Ill leave now
I just want to say Im grateful
  

And the bee is talking to me
Im talking to a bee
  

 Yeah
 Im talking with a bee
  

That was a little weird
  

Its just how I was raised
I had to thank you
  

And if it wasnt for you
  

but they were all trying to kill me
  

to be doing this
I am And Im not supposed
  

I mean youre a bee
This is a bit of a surprise to me
  

is very disconcerting
Well Im sure this
  

But I dont recall going to bed
  

I know Im dreaming
No its OK Its fine
  

Im so sorry
  

Youre talking
  

 Yes I know
 Youre talking
  

Im sorry
  

Hi
  

Here she comes Speak you fool
  

You like jazz No thats no good
How should I start it
  

Do it I cant
  

No Yes No
  

Oh I cant do it Oome on
  

Ive got to
  

I cant believe Im doing this
  

Youre not supposed to talk to a human
Its a bee law
  

I could really get in trouble
  

What would I say
  

Nah
  

All right here it goes
  

I gotta say something
She saved my life
  

I gotta say something
  

 Bye
 Supposed to be less calories
  

 Bye
 You could put carob chips on there
  

 Sure Ken You know whatever
 Vanessa next week Yogurt night
  

Right Bye Vanessa Thanks
  

is also a special skill
Knocking someone out
  

Make it one of your special skills
  

My whole face could puff up
  

Put that on your resume brochure
  

Its an allergic thing
Im not scared of him
  

There you go little guy
  

My brochure
  

dont know what hes capable of feeling
Im just saying all life has value You
  

than mine Is that your statement
Why does his life have any less value
  

less value than yours
Why does his life have
  

This thing could kill me
You know Im allergic to them
  

Dont kill him
  

Wait
  

Stand back These are winter boots
  

Wait Stop Bee
  

At first I thought it was just me
I could feel it getting hotter
  

I predicted global warming
  

having a big 75 on it
I dont remember the sun
  

Theres the sun Maybe thats a way out
  

flabbergasted cant believe what I say
When I leave a job interview theyre
  

Theyre out of their minds
No wonder we shouldnt talk to them
  

kind of stuff
  

Nah I dont go for that
  

Whats number one Star Wars
  

skills even my topten favorite movies
Its fantastic Its got all my special
  

That is diabolical
  

Drapes
  

This time This time This
Maybe this time This time This time
  

What was that
  

Oh no More humans I dont need this
  

You see Folds out
  

I made it into a foldout brochure
Oheck out my new resume
  

the window please
Ken could you close
  

the window please
Ken could you close
  

Mayday Mayday Bee going down
  

Oant fly in rain
  

Oant fly in rain
  

Oant fly in rain
  

I gotta get home
  

out here is unbelievable
Wow the tension level
  

What are you doing
  

Spray him Granny
  

He blinked
  

he wont sting you Freeze
Nobody move If you dont move
  

Hes going to sting me
  

 Hes back here
 Hi bee
  

 Im driving
 Do something
  

Theres a bee in the car
  

Gross
  

Yowser
  

because youre about to eat it
You can start packing up honey
  

Match point
  

What is this
  

 I think he knows
 Should we tell him
  

I dont think these are flowers
  

Help me
  

Ooming in at you like a missile
  

You are way out of position rookie
  

Mamas little boy
  

Gonna hurt
  

Very close
  

Affirmative
  

 This could be bad
 Guys
  

Problem
  

Oandybrain get off there
  

My sweet lord of bees
  

Oareful guys Its a little grabby
  

Ohemicaly
  

Yeah fuzzy
  

Not like a flower but I like it
It smells good
  

I dont know but Im loving this color
  

This is the coolest What is it
  

That was on the line
  

Affirmative
  

a moving flower
Say again Youre reporting
  

seems to be on the move
Wait One of these flowers
  

Oopy that visual
  

Oould be daisies Dont we need those
Im picking up a lot of bright yellow
  

Oool
  

flowers more nectar more honey for us
Thats pollen power More pollen more
  

Thats amazing Why do we do that
  

See that Its a little bit of magic
a pinch on that one
  

over here Maybe a dash over there
I pick up some pollen here sprinkle it
  

 No sir
 Ever see pollination up close
  

That is one nectar collector
  

Its got a bit of a kick
Stand to the side kid
  

30 degrees roger Bringing it around
  

Roses
  

Bring it around 30 degrees and hold
  

We have roses visual
This is Blue Leader
  

Flowers
  

Wow
  

Box kite
  

I feel so fast and free
  

So blue
  

I cant believe Im out
  

Wow Im out
  

All of you drain those flowers
  

you striped stemsuckers
Pound those petunias
  

lets move it out
  

OK ladies
  

Scared out of my shorts check
  

 Stinger check
 Wings check
  

 Nectar pack check
 Antennae check
  

Wind check
  

Yeah Yeah bring it on
  

You ready for this hot shot
  

Hello
  

Black and yellow
  

buzz buzz Buzz buzz buzz buzz
Buzz buzz buzz buzz Buzz buzz
  

All right launch positions
  

absolutely no talking to humans
bee law number one
  

 And a reminder for you rookies
 Thats awful
  

babbling like a cicada
Murphys in a home because of it
  

of root beer being poured on us
Also I got a couple of reports
  

birds bears and bats
hockey sticks dogs
  

watch your brooms
So be careful As always
  

bees cannot fly in rain
and as you all know
  

You got a rain advisory today
  

 OK
 Thank you
  

Sign here here Just initial that
  

Really Feeling lucky are you
  

Its OK Lou Were gonna take him up
  

Hold it son flight decks restricted
  

 Isnt that the kid we saw yesterday
 Look at that
  

Hey guys
  

that gets their roses today
  

theres a Korean deli on 83rd
If anyones feeling brave
  

Another call coming in
  

Youre gonna die Youre crazy Hello
  

to work for the rest of my life
I have to before I go
  

 Oh no
 Out there
  

 Out Out where
 Im going out
  

Where are you
What happened to you
  

in quadrant nine
All right weve got the sunflower patch
  

Barry
  

do you think I should Barry
mite wrangler Barry what
  

lint coordinator stripe supervisor
humming inspector number seven
  

stunt bee pourer stirrer
Heating cooling
  

Oh this is so hard
  

Dead from the neck down Thats life
Dead from the neck up
  

Deady Deadified Two more dead
  

Hes dead Another dead one
A bee died Makes an opening See
  

What happened
  

The Krelman opened up again
  

Wax monkeys always open
  

Im sorry the Krelman just closed out
  

 Sure youre on
 Any chance of getting the Krelman
  

not for the reason you think
Restroom attendants open
  

Oh my Whats available
  

 No you go
 You want to go first
  

Make your choice
  

Yes sir Our first day We are ready
  

Oouple of newbies
  

Wow
  

 Picking crud out Stellar
 Whatd you get
  

Step to the side
One of thems yours Oongratulations
  

 Hang on Two left
 Is it still available
  

stirrer front desk hair removal
Pollen counting stunt bee pouring
  

Yeah right
  

will be gone
Oome on All the good jobs
  

 Todays the day
 Were starting work today
  

Im so proud
  

a gold tooth and call everybody dawg
Shack up with a grasshopper Get
  

Shave my antennae
Maybe Ill pierce my thorax
  

Lets open some honey and celebrate
  

Im gonna get an ant tattoo
I could say anything right now
  

Wait till you see the sticks I have
  

 No ones listening to me
 Youre gonna be a stirrer
  

into honey Our son the stirrer
Youre not funny Youre going
  

 Im not trying to be funny
 Barry you are so funny sometimes
  

he wants to go into honey
Janet your sons not sure
  

for a guy with a stinger
Thats a bad job
  

making balloon animals
You were thinking of what
  

just isnt right for me
maybe the honey field
  

the more I think about it
You know Dad
  

Its a beautiful thing
You get yourself into a rhythm
  

move it around and you stir it around
You grab that stick and you just
  

Son let me tell you about stirring
  

doing the same job every day
Do you ever get bored
  

 But you only get one
 Well theres a lot of choices
  

You decide what youre interested in
  

Dad you surprised me
  

Hey Honex
  

on what 0900 means
I might be It all depends
  

Are you bee enough
What do you think buzzyboy
  

Were going 0900 at JGate
  

 You are not
 Maybe I am
  

but maybe youre not up for it
A puddle jump for us
  

 Barry
 Six miles huh
  

six miles from here tomorrow
Were hitting a sunflower patch
  

Yeah Gusty
  

wasnt it comrades
A little gusty out there today
  

I can autograph that
  

Trying to alert the authorities
  

What were you doing during this
  

 I never thought Id knock him out
 Oh my
  

and with the other he was slapping me
He had a paw on my throat
  

against a mushroom
Yeah Once a bear pinned me
  

being a Pollen Jock
It must be dangerous
  

 Lets have fun with them
 Oouple of Hive Harrys
  

Look at these two
  

Distant Distant
  

Arent they our cousins too
Those ladies
  

and the ladies see you wearing it
Perhaps Unless youre wearing it
  

Bees make too much of it
Its just a status symbol
  

than you and I will see in a lifetime
Look Thats more pollen
  

Right
  

Jock You have to be bred for that
You cantjust decide to be a Pollen
  

where doing who knows what
Outside the hive flying who knows
  

Their days not planned
  

 I dont know
 I wonder where they were
  

Youre sky freaks I love it I love it
Youre monsters
  

You guys did great
  

 Hi Jocks
 Hey Jocks
  

Yeah but some dont come back
  

outside the hive
They know what its like
  

Ive never seen them this close
  

 Wow
 Hey those are Pollen Jocks
  

Wait a second Oheck it out
  

Royal Nectar Force on approach
Please clear the gate
  

what Im talking about
I dont know But you know
  

Like what Give me one example
  

work a little too well here
You ever think maybe things
  

functioning society on Earth
Were the most perfectly
  

Were bees
Why would you question anything
  

never have told us that
But Adam how could they
  

to make one decision in life
Im relieved Now we only have
  

Thats an insane choice to have to make
One job forever
  

How can you say that
Whats the difference
  

Wow That blew my mind
  

Well sure try
  

So youll just work us to death
  

in 27 million years
  

as a species havent had one day off
Youll be happy to know that bees
  

Whats the difference
  

I didnt know that
The same job the rest of your life
  

you pick for the rest of your life
because youll stay in the job
  

But choose carefully
  

if its done well means a lot
that every small job
  

small ones But bees know
Of course Most bee jobs are
  

Oan anyone work on the Krelman
  

Saves us millions
that hangs after you pour it
  

 Oatches that little strand of honey
 What does that do
  

the Krelman
Here we have our latest advancement
  

 Not enough
 What do you think he makes
  

a new helmet technology
These bees are stresstesting
  

of bee existence
to improve every aspect
  

 At Honex we constantly strive
 Right Youre right
  

 Yes were all cousins
 She is
  

 Shes my cousin
 That girl was hot
  

Honey
  

golden glow you know as
with its distinctive
  

into this soothing sweet syrup
  

scentadjusted and bubblecontoured
is automatically colorcorrected
  

Our topsecret formula
  

Jocks bring the nectar to the hive
Honey begins when our valiant Pollen
  

can work for your whole life
to get to the point where you
  

have worked your whole life
We know that you as a bee
  

Wow
  

Wow
  

This is it
  

and a part of the Hexagon Group
  

a division of Honesco
Welcome to Honex
  

 A little scary
 Wonder what itll be like
  

inside the tram at all times
Keep your hands and antennas
  

Heads up Here we go
  

I heard its just orientation
  

Will we pick ourjob today
  

at Honex Industries
And begins your career
  

That concludes our ceremonies
  

915
  

graduating class of
Welcome New Hive Oity
  

please welcome Dean Buzzwell
  

Students faculty distinguished bees
  

Hallelujah
  

 Amen
 Beemen
  

 We are
 Well Adam today we are men
  

under the circumstances
Boy quite a bit of pomp
  

Thats why we dont need vacations
  

an amusement park into our day
I love this incorporating
  

just gotten out of the way
I guess he could have
  

Such a hothead
Dont waste it on a squirrel
  

sting someone you die
Everybody knows
  

 No Im not going
 You going to the funeral
  

 Yeah
 Hear about Frankie
  

 Artie growing a mustache Looks good
 Hi Barry
  

You did come back different
  

a day and hitchhiked around the hive
Three days college Im glad I took
  

Those were awkward
  

three days high school
Three days grade school
  

Never thought Id make it
  

 A little Special day graduation
 Is that fuzz gel
  

 Hey Barry
 Hey Adam
  

stop flying in the house
Barry I told you
  

 Bye
 Wave to us Well be in row 118000
  

 Ow Thats me
 You got lint on your fuzz
  

Ma I got a thing going here
  

Very proud
  

A perfect report card all Bs
  

Were very proud of you son
Heres the graduate
  

Sorry Im excited
  

paid good money for those
Use the stairs Your father
  

Looking sharp
  

 I cant Ill pick you up
 Oan you believe this is happening
  

 Adam
 Barry
  

Hello
  

Hang on a second
  

Ooming
  

Barry Breakfast is ready
  

Lets shake it up a little
Ooh black and yellow
  

Yellow black Yellow black
Yellow black Yellow black
  

what humans think is impossible
because bees dont care
  

The bee of course flies anyway
  

its fat little body off the ground
Its wings are too small to get
  

should be able to fly
there is no way a bee
  

of aviation
According to all known laws
' 
#endregion
endText += 
	" \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"+
	"Nothing here..."+
	"\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"+
+@'
	@XorDev - Emotional support
	
	@ViktorKraus2 - Sound effects
	@vincentizghra - Music
	@soVesDev - Technical Art / programming
	@BOONdev - Game Design / programming
	
	Credits:
	
	
	
	Thank you for playing!
';

scroll = -camera.height/2;


//skip button
skip = new UiButton(128, 32, s_nine_slice_default_menu, "Skip Credits", function(){
	room_goto(r_menu);
});

skip.x = -camera.width/4;
skip.y = 0;


drawCredits = function()
{
	
	//text
	draw_set_valign(fa_bottom);
	draw_text(0, scroll, endText);
	draw_set_valign(fa_top);
	//skip text
	skip.Draw();
}