<?php
/*
 * Import de la bibliothèque de fonctions gérant les requêtes SQL
 */
include "db.php";


$surname = $_POST['nom'];
$firstname = $_POST['prenom'];
$pseudo = $_POST['pseudo'];
$email = $_POST['email'];
$pw_hash = password_hash($_POST['pw'], PASSWORD_DEFAULT);
//Avatar?



$data_user = [
  'nom'=> $surname,
  'prenom' => $firstname,
  'pseudo' => $pseudo,
  'email' => $email,
  'mdp' => $pw_hash,
  //Avatar ?
];

$insert_user = $db -> prepare
('
  INSERT INTO utilisateur (nom, prenom, pseudo, mdp, email)
  VALUES (:nom, :prenom, :pseudo, :mdp, :email);
');

$insert_user -> execute($data_user);
//var_dump($data_billet);die;
header('Location: ../../index.php');
?>
