# Plotfunction for a Geomol Edgelist
Plot networks from edgelists downloaded from Geomol.

Download the function and source it with R or R studio.

The function has the following parameters:

* edgelist # Your edgelist as supplied by Geomol, 
* selected_formula # If supplied a formula inside the edgelist can be coloured (default to NULL, no formula), 
* color_by # the element you want to show a color gradient e.g. "C" 
* cols # the colors you want to use to show the gradient e.g. c("green","red")
* labelsize # the fontsize of your labels e.g. 20
* staticlayout # should the network use physics to center itself
 
Run the function with your downloaded edgelist e.g. 
```
plot_edgelist(edgelist='name of your edgelist',selected_formula = NULL,color_by="H",cols=c("green","purple"),labelsize=40,staticlayout=T)
```

Have fun creating networks of homologous series!













used packages:

* Almende B.V., Benoit Thieurmel and Titouan Robert (2018). visNetwork: Network Visualization using 'vis.js'
  Library. R package version 2.0.3. https://CRAN.R-project.org/package=visNetwork
  
* Hadley Wickham, Romain François, Lionel Henry and Kirill Müller (2018). dplyr: A Grammar of Data
  Manipulation. R package version 0.7.8. https://CRAN.R-project.org/package=dplyr
  
* Erich Neuwirth (2014). RColorBrewer: ColorBrewer Palettes. R package version 1.1-2.
  https://CRAN.R-project.org/package=RColorBrewer
