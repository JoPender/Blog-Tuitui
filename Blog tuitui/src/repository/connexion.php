
<?php
/*
 * Import de la bibliothèque de fonctions gérant les requêtes SQL
 */
include "db.php";


//Récupération de l'utilisateur et son pw hashé
$pseudo = $_POST['pseudo'];

$req = $db -> prepare
(
  'SELECT id, mdp
  FROM utilisateur
  WHERE pseudo = :ouioui
');
$req ->  execute(array(
  'ouioui' => $pseudo
));
$resultat = $req->fetch();
//var_dump($resultat);die;

//Comparaison du pass envoyé via le formulaire avec la db

$isPwCorrect = password_verify($_POST['pw'],substr($resultat['mdp'],0,60));

if (!$resultat){
  echo 'Mauvais identifiant!';

}else {
  if($isPwCorrect){
    session_start();
    $_SESSION['id']=$resultat['id'];
    $_SESSION['pseudo'] = $pseudo;

    echo 'Vous êtes connecté!';
  }else{
    echo 'Mauvais identifiant ou mot de passe!';
  }
}

if (isset($_SESSION['id']) AND isset($_SESSION['pseudo']))
{
  echo 'BonJour '.$_SESSION['pseudo'];
  $_SESSION['connect'] = true;
  header('Location: ../../index.php');
}

 ?>
