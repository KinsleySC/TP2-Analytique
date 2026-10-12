# Hiérarchie

Sarah Morel, id 1, est au niveau 0.
Lucas Petit, id 2, dépend de Sarah : niveau 1.
Jade Roux, id 5, dépend de Lucas : niveau 2.
Nathan Vincent, id 14, dépend de Jade : niveau 3.

Le chemin de Nathan est Sarah Morel > Lucas Petit > Jade Roux > Nathan Vincent.

Une clé étrangère seule n’empêche pas un cycle. Le CHECK manager_id < id impose que chaque remontée diminue l’identifiant. Dans une table finie, on ne peut donc pas revenir au point de départ. Cette règle est simple, mais un nouveau manager ne peut pas avoir un identifiant supérieur à celui de son subordonné.
