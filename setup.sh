# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    setup.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: user42 <user42@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/08/12 16:55:22 by jsaguez           #+#    #+#              #
#    Updated: 2020/08/13 12:13:04 by user42           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

:> errlog.txt
:> log.log

echo "Minikube starting..."
minikube start --cpus=2 --memory=3000 --disk-size=8000mb --vm-driver=docker
minikube addons enable metrics-server
minikube addons enable metallb >> log.log 2>>errlog.txt && sleep 2 && kubectl apply -f ./srcs/metallb.yaml >> log.log 2>>errlog.txt
minikube addons enable dashboard