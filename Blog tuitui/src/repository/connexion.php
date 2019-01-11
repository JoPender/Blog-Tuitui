
<?php
/*
 * Import de la bibliothèque de fonctions gérant les requêtes SQL
 */
include "db.php";
/*
 * Connexion à la base de données
 */
$db = openDatabase('blog1','root','troiswa');

//Récupération de l'utilisateur et son pw hashé
$pseudo = $_POST['pseudo'];

$req = $db -> prepare('
  SELECT id, pw
  FROM $utilisateur
  WHERE pseudo = :pseudo
');
$req ->  execute(array(
  'pseudo' => $pseudo
));
$resultat = $req->fetch();
//var_dump($resultat);die;

//Comparaison du pass envoyé via le formulaire avec la db

$isPwCorrect = password_verify($_POST['pw'],$resultat['pw']);

if (!$resultat){
  echo 'Mauvais identifiant ou mot de passe';
}else {
  if(isPwCorrect){
    session_start();
    $_SESSION['id']=$resultat['id'];
    $_SESSION['pseudo']=$pseudo;
    echo'Vous êtes connecté!';
  }else{
    echo 'Mauvais identifiant ou mot de passe!';
  }
}
var_dump($resultat);
if (isset($_SESSION['id']) AND isset($_SESSION['pseudo']))
{
  echo 'BonJour'.$_SESSION['pseudo'];
}
 ?>
