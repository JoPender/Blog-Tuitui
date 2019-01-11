<?php
/*
 * Import de la bibliothèque de fonctions gérant les requêtes SQL
 */
include "db.php";
/*
 * Connexion à la base de données
 */
$db = openDatabase('blog1','root','troiswa');

$titre = $_POST['titre'];
$content = $_POST['corps_de_texte'];
$date_edition = $_POST['date_edition'];
//$image = addslashes(file_get_contents($_FILES['image']['tmp_name']));
//$categorie = $_POST['theme'];

//var_dump($_FILES); die;
$fileName = $_FILES['image']['name'];
$tmp = $_FILES['image']['tmp_name'];


move_uploaded_file($tmp, '/home/wamont2-12/sites/developpement/Blog tuitui/public/images/voyages/'.$fileName);
$_POST['image'] = $fileName;


$data_billet = [
  'titre'=> $titre,
  'corps_de_texte' => $content,
  'date_edition' => $date_edition,
//  'theme' => $categorie,
  'image' => $fileName
];

$insert_billet = $db -> prepare
('
  INSERT INTO billet (titre, image, corps_de_texte, date_edition)
  VALUES (:titre, :image, :corps_de_texte, :date_edition);
');

$insert_billet -> execute($data_billet);
//var_dump($data_billet);die;
header('Location: ../../index.php');
?>
