
[Stack Overflow](https://stackoverflow.com/questions/342687/algorithm-to-implement-a-word-cloud-like-wordle)


I'm the creator of Wordle. Here's how Wordle actually works:



Count the words, throw away boring words, 
and sort by the count, descending. 
Keep the top N words for some N. 
Assign each word a font size proportional 
to its count. Generate a Java2D 
Shape for each word, using the Java2D API.

Each word "wants" to be somewhere, 
such as "at some random x position 
in the vertical center". In decreasing 
order of frequency, do this for each word:

place the word where it wants to be
while it intersects any of the previously placed words
 move it one step along an ever-increasing spiral

That's it. The hard part is in doing the 
intersection-testing efficiently, 
for which I use last-hit caching,
 hierarchical bounding boxes, 
 and a quadtree spatial index 
 (all of which are things you can 
 learn more about with some 
 diligent googling).

Edit: As Reto Aebersold pointed out
, there's now a book chapter
, freely available, that covers 
this same territory: Beautiful Visualization, Chapter 3: 
[Wordle](http://static.mrfeinberg.com/bv_ch03.pdf)


## Quad Trees


    1. Divide the current two dimensional s
    pace into four boxes.
    
    2. If a box contains one or more 
    points in it, create a child object, 
    storing in it the two dimensional space of the box
    
    3. If a box does not contain any points, 
    do not create a child for it
    
    4. Recurse for each of the children.


[the PR quad tree](https://opendsa-server.cs.vt.edu/ODSA/Books/CS3/html/PRquadtree.html)

Hanan Samet: Foundations of Multidimensional and Metric Data Structures

[Samet](https://books.google.fr/books?id=vO-NRRKHG84C&pg=PA212&lpg=PA212&dq=region+quadtree&source=bl&ots=f-Fd5pSIYt&sig=ACfU3U1Ph-uYjiwoB2GxHY67n9B7X2bauQ&hl=en&sa=X&ved=2ahUKEwi76OLKwI3oAhVF6RoKHa0TBlo4ChDoATASegQIChAB#v=onepage&q=region%20quadtree&f=false)