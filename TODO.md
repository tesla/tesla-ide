There is no easy way to have a unified theme and control all the settings pertaining to a theme. There is a decent start with eclipse-themes and eclipsecolorthemes but it's not very easy to make a default build use custom values and editing these values is also not easy. The eclipse-themes has a pretty nice way to edit themes in the IDE, but editing the eclipsecolorthemes doesn't allow any easy editing and testing. Eclipsecolorthemes writes out normal preferences but it could be made easier. Ideally we would use CSS to fully control everything in a standard way even if we have to write some bridges to map the CSS to the where the values actually belong.

- find a way to store a custom theme during a build of the distribution and default to that theme
 - this is using https://github.com/jeeeyul/eclipse-themes
- find a way to store a custom eclipsecolor theme during a build of the distribution and default to that theme
 - this is using http://eclipsecolorthemes.org
