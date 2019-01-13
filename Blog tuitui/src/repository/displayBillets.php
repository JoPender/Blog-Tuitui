<?php

/*
 * Import de la bibliothèque de fonctions gérant les requêtes SQL
 */
include "db.php";


$displayBillets = $db -> prepare
(
  'SELECT b.*, c.nom, u.pseudo
  FROM billet as b
  INNER JOIN categorie as c on b.categorie = c.id
  INNER JOIN utilisateur as u on b.auteur = u.id
  ORDER BY b.date_publication DESC;
');

$displayBillets -> execute();
$_SESSION['display'] = $displayBillets -> fetchAll(PDO::FETCH_ASSOC);


 ?>
