Demo link: https://drive.google.com/open?id=1LLhVdxK7mZTUu-_JikUbZwhOGfPzu53V

I created the circuit described in Jesus's slides, instead of a normal inductor, however, I used a coil of wire.
The output of the NOT gate was put into a pin, and the pin measured the frequency of the output.
It spends a couple seconds getting a reference frequency,a frequency where there's nothing inside of it.
And then it constantly compares the reference frequency with the frequency is measures. If the frequency is 
different it assumes there's a piece of metal around it and beeps.

Extra features:
- The frequency does not stay constant, it tends to change between 2 or 3 frequencies. I created a process
that ensured it was always accurate with the frequency. It recorded the different frequencies and counted
how many times that frequency appears. After a certain number of loops it determines what the frequency is by
taking the frequency that shows up the most. This ensures that it is more accurate when measuring frequency

- Created a mode where if you want to compare two or more metals, you press a button and it keeps the old frequency 
but starts measuring a new frequency and displays it using a RED LED, pressing the button again returns you
to normal metal detector mode

- Uses different magnitudes of frequency to figure out what kind of metal and material it is being exposed to.
Pressing a button identifies the object inside the detector, the main magnetic material, the net cost of the 
material per approximate weight, and the Curie Temperature

- Pressing another button puts it in a "graphing mode" where the output of the NOT gate can be plotted on Python

- Extra LED turns on when in graphing mode, pressing the graph button again returns you to normal metal detector 
mode

References:
- Jesus's slides
- Price of materials: https://iscrapapp.com/prices/
- Curie Temperatures: https://hypertextbook.com/facts/2005/StephanieMa.shtml