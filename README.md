# ScreenTimerProtection
Un script PowerShell permettant de mettre automatiquement en veille au bout d'une heure l'ordinateur.

# Explications détaillées
Ce script, une fois démarrer va kill tous script de même nom puis se mettre en pause pendant X minutes (ici 59 minutes).
Une fois ces minutes passées, une fenêtre de choix Windows va apparaître pour donner le choix à l'utilisateur de repoussé de X minutes (ici 1 minute) la mise en veille de l'ordinateur.
Tant que le choix sur cette fenêtre n'est pas effectuer, un son sera jouer (ici Alarm01.wav, l'alarme de base de Windows).

- Si l'utilisateur choisi de repousser la mise en veille, 1 minutes plus tard, cette même fenêtre s'ouvrira.
- Si l'utilisateur ne choisi pas de repousser la mise en veille, 1 minutes plus tard, un son sera jouer (ici ALARM.wav récupérer d'un site de son libre de droit) pendant 15 secondes pour prévenir la mise en veille imminente.

Puis l'ordinateur est mis en veille.

# Conseils d'utilisation
Le mieux est de faire en sorte que ce script s'active automatiquement en arrière plan (sans que cela puisse être visible) lorsque l'ordinateur démarre et lorsque l'ordinateur sort de la veille. 

Par exemple : 
- pour le démarrage de l'ordinateur, il suffit de placer le raccourci (.Ink) dans le dossier Démarrage (Startup en anglais) de Windows.
- pour la sortie de mise en veille de l'ordinateur, il suffit de créer une tâche dans taskschd.msc et importer l'XML.