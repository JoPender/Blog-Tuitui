-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2.1
-- http://www.phpmyadmin.net
--
-- Client :  localhost
-- Généré le :  Ven 28 Décembre 2018 à 17:47
-- Version du serveur :  5.7.24-0ubuntu0.16.04.1
-- Version de PHP :  7.0.32-0ubuntu0.16.04.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `blog1`
--

-- --------------------------------------------------------

--
-- Structure de la table `billet`
--

CREATE TABLE `billet` (
  `id` bigint(11) NOT NULL,
  `titre` varchar(200) NOT NULL,
  `sous_titre` varchar(200) NOT NULL,
  `corps_de_texte` text NOT NULL,
  `image` varchar(128) NOT NULL,
  `date_publication` datetime NOT NULL,
  `categorie` bigint(11) NOT NULL,
  `likes` int(11) NOT NULL,
  `dislikes` tinyint(4) NOT NULL,
  `favori` tinyint(4) NOT NULL,
  `auteur` bigint(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `categorie`
--

CREATE TABLE `categorie` (
  `id` bigint(11) NOT NULL,
  `id_parent` bigint(11) NOT NULL,
  `nom` varchar(64) NOT NULL,
  `description` text NOT NULL,
  `image` varchar(128) NOT NULL,
  `date_publication` datetime NOT NULL,
  `date_creation` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `commentaire`
--

CREATE TABLE `commentaire` (
  `id` bigint(11) NOT NULL,
  `auteur` bigint(11) NOT NULL,
  `date_publication` datetime NOT NULL,
  `texte` text NOT NULL,
  `image` varchar(64) NOT NULL,
  `reponse_commentaire` text NOT NULL,
  `likes` int(11) NOT NULL,
  `dislikes` int(11) NOT NULL,
  `valider_commentaire` tinyint(1) NOT NULL,
  `billet` bigint(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `role`
--

CREATE TABLE `role` (
  `id` bigint(11) NOT NULL,
  `titre` varchar(64) NOT NULL,
  `description` text NOT NULL,
  `id_parent` bigint(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `tag`
--

CREATE TABLE `tag` (
  `id` bigint(11) NOT NULL,
  `nom_tag` varchar(64) NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `tag_billet`
--

CREATE TABLE `tag_billet` (
  `id_billet` bigint(11) NOT NULL,
  `id_tag` bigint(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

CREATE TABLE `utilisateur` (
  `id` bigint(11) NOT NULL,
  `nom` varchar(64) NOT NULL,
  `prenom` varchar(64) NOT NULL,
  `pseudo` varchar(128) DEFAULT NULL,
  `mdp` varchar(64) NOT NULL,
  `email` varchar(96) NOT NULL,
  `tel` varchar(20) DEFAULT NULL,
  `role` bigint(11) DEFAULT NULL,
  `avatar` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Index pour les tables exportées
--

--
-- Index pour la table `billet`
--
ALTER TABLE `billet`
  ADD PRIMARY KEY (`id`),
  ADD KEY `categorie` (`categorie`),
  ADD KEY `auteur` (`auteur`);

--
-- Index pour la table `categorie`
--
ALTER TABLE `categorie`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_parent` (`id_parent`),
  ADD KEY `id` (`id`);

--
-- Index pour la table `commentaire`
--
ALTER TABLE `commentaire`
  ADD PRIMARY KEY (`id`),
  ADD KEY `auteur` (`auteur`),
  ADD KEY `id` (`id`),
  ADD KEY `billet` (`billet`);

--
-- Index pour la table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_parent` (`id_parent`);

--
-- Index pour la table `tag`
--
ALTER TABLE `tag`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_tag` (`id`),
  ADD KEY `if_billet` (`nom_tag`);

--
-- Index pour la table `tag_billet`
--
ALTER TABLE `tag_billet`
  ADD PRIMARY KEY (`id_billet`),
  ADD KEY `id_tag` (`id_tag`);

--
-- Index pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  ADD PRIMARY KEY (`id`),
  ADD KEY `role` (`role`),
  ADD KEY `id` (`id`);

--
-- AUTO_INCREMENT pour les tables exportées
--

--
-- AUTO_INCREMENT pour la table `billet`
--
ALTER TABLE `billet`
  MODIFY `id` bigint(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `categorie`
--
ALTER TABLE `categorie`
  MODIFY `id` bigint(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `tag`
--
ALTER TABLE `tag`
  MODIFY `id` bigint(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  MODIFY `id` bigint(11) NOT NULL AUTO_INCREMENT;
--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `billet`
--
ALTER TABLE `billet`
  ADD CONSTRAINT `billet_ibfk_1` FOREIGN KEY (`auteur`) REFERENCES `utilisateur` (`id`),
  ADD CONSTRAINT `id_categorie` FOREIGN KEY (`categorie`) REFERENCES `categorie` (`id`);

--
-- Contraintes pour la table `categorie`
--
ALTER TABLE `categorie`
  ADD CONSTRAINT `parent_id_categorie` FOREIGN KEY (`id_parent`) REFERENCES `categorie` (`id`);

--
-- Contraintes pour la table `commentaire`
--
ALTER TABLE `commentaire`
  ADD CONSTRAINT `auteur_id_utilisateur` FOREIGN KEY (`auteur`) REFERENCES `utilisateur` (`id`),
  ADD CONSTRAINT `billet_id_billet` FOREIGN KEY (`billet`) REFERENCES `billet` (`id`);

--
-- Contraintes pour la table `role`
--
ALTER TABLE `role`
  ADD CONSTRAINT `role_id_role` FOREIGN KEY (`id_parent`) REFERENCES `role` (`id`);

--
-- Contraintes pour la table `tag_billet`
--
ALTER TABLE `tag_billet`
  ADD CONSTRAINT `tag_id_billet` FOREIGN KEY (`id_billet`) REFERENCES `billet` (`id`),
  ADD CONSTRAINT `tag_id_tag` FOREIGN KEY (`id_tag`) REFERENCES `tag` (`id`);

--
-- Contraintes pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  ADD CONSTRAINT `utilisateur_id_role` FOREIGN KEY (`role`) REFERENCES `role` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
