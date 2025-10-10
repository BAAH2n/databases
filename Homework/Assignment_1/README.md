I have different tables about stations from Kyiv's metro, and I joined all the tables, giving the possibility to see all the information about the stations in one table. 
In joining, I use CTE to get only those architects who created more than 1 station. And then use a subquery with "WHERE" to see what station is deeper than average.
But stations have more than 1 architect, so after the joining, I had a few rows with the same station, but different architects. So I asked AI to give me a function that can group items by the left columns and give me values separated by "," in the right column.
So I used function GROUP_CONCAT. Prompt: https://g.co/gemini/share/a90ffda10df5
