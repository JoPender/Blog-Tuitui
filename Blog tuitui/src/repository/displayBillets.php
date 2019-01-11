<?php

/*
 * Import de la bibliothèque de fonctions gérant les requêtes SQL
 */
include "db.php";

/*
 * Connexion à la base de données
 */
$db = openDatabase('blog1','root','troiswa');

$displayBillets = $db -> prepare
('
  SELECT b.*, ut.pseudo, cat.nom
  FROM billet as b
  INNER join utilisateur as ut on ut.id = b.auteur
  INNER join categorie as cat on cat.id = b.categorie
  ORDER BY b.date_publication ASC

');

$displayBillets -> execute();
$displayBillets_result = $displayBillets -> fetchAll(PDO::FETCH_ASSOC);


 ?>
