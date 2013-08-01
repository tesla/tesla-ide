#!/usr/bin/env ruby

# Copyright (c) 2013 to Jason van Zyl
# All rights reserved. This program and the accompanying materials                                                                                                                                          
# are made available under the terms of the Eclipse Public License v1.0                                                                                                                                     
# which accompanies this distribution, and is available at                                                                                                                                                  
# http://www.eclipse.org/legal/epl-v10.html   

require 'mustache'
require 'rexml/document'
require 'yaml'
include REXML

featureDefs = YAML.load_file('product.yml')

repositories = []
features = []
featureSets = []

featureDefs['repos'].each do |repo|
  repositories << repo
end

featureDefs['featureSets'].each do |featureSetHolder|
  featureSetHolder.each do |id,featureSet|
    unless featureSet['repo'].nil?
      repository = { 'id' => id, 'url' => featureSet['repo'] }
      repositories << repository
    end
    featureSets << featureSet
    featureSet['features'].each do |feature|
      features << feature
    end
  end
end

pluginId = "io.tesla.ide"
featureDirectory = pluginId + ".feature"
productDirectory = pluginId + ".rcp"

# Create vars to inject into the mustache template rendering process
# TODO: these should all be captured in the product file
vars = {}
vars[:launcherName] = "TeslaIDE"
vars[:groupId] = "io.tesla.ide"
vars[:mavenVersion] = "1.0.0-SNAPSHOT"
vars[:tychoVersion] = "0.16.0"
vars[:version] = "1.0.0.qualifier"
vars[:pluginId] = pluginId
vars[:featureId] = featureDirectory
vars[:productDirectory] = productDirectory
vars[:productId] = featureDefs['productId']
vars[:repositories] = repositories
vars[:features] = features
featureDefs['platforms'].each do |platform|
  vars[platform] = platform
end

# Plugin
template = File.open('templates/plugin.mustache').read
plugin = Mustache.render(template, vars)  
File.open(pluginId + "/plugin.xml", 'w') { |f| 
  f.write(plugin) 
}

# Feature
template = File.open('templates/feature.mustache').read
feature = Mustache.render(template, vars)  
File.open(featureDirectory + "/feature.xml", 'w') { |f| 
  f.write(feature) 
}

# Product
template = File.open('templates/product.mustache').read
product = Mustache.render(template, vars)  
File.open("io.tesla.ide.rcp/io.tesla.ide.rcp.product", 'w') { |f| 
  f.write(product) 
}

# Poms
pomTemplate = File.open('templates/pom.parent.mustache').read
parentPom = Mustache.render(pomTemplate, vars)  
File.open("pom.xml", 'w') { |f| 
  f.write(parentPom) 
}

pomTemplate = File.open('templates/pom.product.mustache').read
productPom = Mustache.render(pomTemplate, vars)  
File.open(productDirectory + "/pom.xml", 'w') { |f| 
  f.write(productPom) 
}



