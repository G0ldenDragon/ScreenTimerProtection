# Import des classes
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Récupération de l'ID du processus actuel
$currentProcessId = $PID

# Recherche et arrêt de l'ancien script MiseEnVeille.ps1, en excluant le processus actuel
Get-CimInstance Win32_Process -Filter "Name='powershell.exe' OR Name='pwsh.exe'" |
    Where-Object { 
        $_.CommandLine -like "*MiseEnVeille.ps1*" -and $_.ProcessId -ne $currentProcessId 
        } |
        ForEach-Object { 
            Stop-Process -Id $_.ProcessId -Force
            Write-Host "Un ancien script MiseEnVeille.ps1 (Process ID: $($_.ProcessId)) a été arrêté."
        }

Write-Host "Le script actuel MiseEnVeille.ps1 (Process ID: $currentProcessId) en cours d'exécution."

# 1h - 5 mins = 55 mins
$secondes = 59 * 60
# Mise en attente
Start-Sleep -Seconds $secondes

# Initialisations
$veille = $false
$secondes = 1 * 60
# -ne : != (différent de) ; -eq : = (égal à)
while ($veille -eq $false)
{
    Write-Host "--- Fin de l'attente. ---"
    # Son jouer en boucle
    $soundFile = "Alarm01.wav"

    # Création du lecteur audio
    $player = New-Object System.Media.SoundPlayer
    $player.SoundLocation = $soundFile

    # Jouer le son en boucle
    $player.PlayLooping()

    # Affichage de la boîte de message avec les boutons "Oui" et "Non"
    $response = [System.Windows.Forms.MessageBox]::Show(
        # Message à afficher
        "Retarder la mise en veille qui aura lieu dans 1 mins ?",

        # Titre de la boîte de dialogue
        "Mise en veille automatique dans peu de temps !",

        [System.Windows.Forms.MessageBoxButtons]::YesNo, # Boutons à afficher
        [System.Windows.Forms.MessageBoxIcon]::Warning  # Icône à afficher
    )

    # Vérification de la réponse de l'utilisateur
    if ($response -eq [System.Windows.Forms.DialogResult]::Yes) 
    {
        Write-Host "Mise en veille retardée..."
    } 
    else 
    {
        Write-Host "Mise en veille dans 1 minutes..."
        $veille = $true
    }

    # Une fois la boîte de message fermée, arrêter le son
    $player.Stop()
    Start-Sleep -Seconds $secondes
}

# Prévention que ce sont les 15 dernières secondes.
Write-Host "Mise en veille dans 15 secondes..."
$soundFile = "ALARM.wav"
$player = New-Object System.Media.SoundPlayer
$player.SoundLocation = $soundFile
$player.PlayLooping()
Start-Sleep -Seconds 15
$player.Stop()

# Mise en veille de l'ordinateur.
rundll32.exe powrprof.dll,SetSuspendState 0,1,0