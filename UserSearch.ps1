Add-Type -AssemblyName System.Windows.Forms 
Add-Type -AssemblyName System.Drawing 

#La forme principale 
$form = New-Object System.Windows.Forms.Form 
$form.Text = "User Search" 
$form.Size = New-Object System.Drawing.Size(300,200) 
$form.StartPosition = "CenterScreen" 

#Le bouton OK 
$OKButton = New-Object System.Windows.Forms.Button 
$OKButton.Location = New-Object System.Drawing.Point(75,120) 
$OKButton.Size = New-Object System.Drawing.Size(75,23) 
$OKButton.Text = "OK" 
$OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK 
$form.AcceptButton = $OKButton 
$form.Controls.Add($OKButton) 

#Le bouton Cancel 
$CancelButton = New-Object System.Windows.Forms.Button 
$CancelButton.Location = New-Object System.Drawing.Point(150,120) 
$CancelButton.Size = New-Object System.Drawing.Size(75,23) 
$CancelButton.Text = "Cancel" 
$CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel 
$form.CancelButton = $CancelButton 
$form.Controls.Add($CancelButton) 

#Le nom du label 
$label = New-Object System.Windows.Forms.Label 
$label.Location = New-Object System.Drawing.Point(10,20) 
$label.Size = New-Object System.Drawing.Size(280,20) 
$label.Text = "Entrez le nom de l'utilisateur / Ordinateur recherché :" 
$form.Controls.Add($label) 

#le champ qui recoit l'input 
$textBox = New-Object System.Windows.Forms.TextBox 
$textBox.Location = New-Object System.Drawing.Point(10,40) 
$textBox.Size = New-Object System.Drawing.Size(260,20) 
$form.Controls.Add($textBox) 

#la forme est toujours au-dessus de toutes les fenetres 
$form.Topmost = $True 

#le focus est sur la "Textbox" 
$form.Add_Shown({$textBox.Select()}) 
$result = $form.ShowDialog() 

if ($result -eq [System.Windows.Forms.DialogResult]::OK) 
{ 
    #Variable nom recherché 
    $var = $textBox.Text 

    #Recherche dans l'AD et renvoie de la réponse dans une grille 
    Get-ADComputer -SearchBase "OU=METS,OU=TON,OU=OU,DC=ET,DC=TON,DC=DOMAINE,DC=AD,DC=ICI" -Filter * -Properties Description | Where-Object {$_.Description -like "*$var*"} | select Description, Name | ogv 
    Pause 
} 
