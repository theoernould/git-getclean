# Fetch les branches à distance
Write-Host "Fetching les branches à distance..."
git fetch --all --prune

# Récupérer les branches distantes et locales
Write-Host "Récupération des branches distantes et locales..."
$remoteBranches = git branch -r | % { $_.Trim() -replace "origin/", "" } | Sort-Object
$localBranches = git branch | % { $_.Trim('*').Trim() } | Sort-Object

# Supprimer les branches locales qui ne se trouvent pas en remote
Write-Host "Suppression des branches locales qui ne se trouvent pas en remote..."
$localBranchesToDelete = $localBranches | ? { $remoteBranches -notcontains $_ }
foreach ($branch in $localBranchesToDelete) {
    Write-Host "Suppression de la branche locale : $branch"
    git branch -D $branch
}

# Mettre à jour les branches locales
Write-Host "Mise à jour des branches locales..."
foreach ($branch in $localBranches) {
    # Sauvegarder la branche courante
    $currentBranch = git symbolic-ref --short HEAD

    # Essayer de changer de branche et de pull
    try {
        Write-Host "Mise à jour de la branche : $branch"
        git checkout $branch -q

        # Vérifier s'il y a des changements locaux et stash si nécessaire
        $changes = git status --porcelain
        if ($changes) {
            $stashName = "Stash_$branch_" + (Get-Date -Format "yyyyMMdd_HHmmss")
            Write-Host "Stashing les changements locaux sur la branche $branch sous le nom : $stashName"
            git stash save $stashName
        }

        git pull origin $branch --ff-only -q
    }
    catch {
        Write-Host "Erreur lors de la mise à jour de la branche $branch. Ignorée."
    }
    finally {
        # Restaurer la branche courante
        git checkout $currentBranch -q
    }
}
Write-Host "Mise à jour des branches terminée."
