# Jquery file Upload

For a while I've been having the idea of setting up a multi file upload on a cms application I'm working on; I read about [jquery file upload](http://blueimp.github.com/jQuery-File-Upload/) a while ago, but never got around to read the documentation and do an exercise. 

Today I decided I would build a sample app that would allow users to create a gallery and add photos to it.

In addition to the jquery file upload plugin I am using a few gems to develop the rails application quite faster.

[Paperclip](https://github.com/thoughtbot/paperclip): This is a great app for uploading files to the server 

[twitter-bootstrap-rails](https://github.com/seyhunak/twitter-bootstrap-rails): This gem allows you to work with twitter bootstrap very easily and puts the required files in the asset pipeline

[simple_form](https://github.com/plataformatec/simple_form): I added this because I've noticed that forms become much less cluttered with it besides it has some great helpers for twitter bootstrap

[Jbuilder](https://github.com/rails/jbuilder): This is a great templating gem for json it will be quite useful to format the results in the way that the plugin requires it for the default demo.

## So how do I get my multi file uploader working

The first time I was writing this post I listed all the steps for set up of the app but instead I am going to cheat and only going to point to the important parts. 

### The model

I am using paperclip to upload files easily, the configuration for this is quite simple on the model

    class Photo < ActiveRecord::Base
    	...
    	has_attached_file :file
    end

### The view

I am using the view provided on the demo, also included in the zip file when you download the plugin from github. I did do some changes such as downloading a bunch of dependencies not included in the zip and call the javascripts using the javascript include tag, for more information refer to the show view for albums in this repository.

### The json response

The default layout for the plugin demo requires you to return a json with the following format.

    [
      {
        "name": "photo.png",
        "size": 20619,
        "url": "http://url/to/photo.png"
        "thumbnail_url": "http://url/to/photo_thumb.png"
        "delete_url": "http://url/to/delete",
        "delete_type": "DELETE"
      }
    ]


By default the scaffolded controller returns a json representation of the object but it does not match this one, for that we will use jbuilder with the following code

    # index.json.jbuilder

    json.array!(@photos) do |json, photo|
      json.name photo.file_file_name
      json.size photo.file_file_size
      json.url photo.file.url(:original)
      json.thumbnail_url photo.file.url(:thumb)
      json.delete_url album_photo_url(@album, photo)
      json.delete_type "DELETE"
    end

### The controller

The above template works great for the index action, but not so great for the create action, as the uploader expects only one file instance inside the json array so the normal redirect on the create action won't do; instead we can assign assign the recently saved @photo into @photos as an array and render the index if the format required is json. 

    class PhotosController < ApplicationController
      ...
      def index
      	@photos = @album.photos
      end
      ...
      def create
        @photo = @album.photos.new(params[:photo])

        if @photo.save
          respond_to do |format|
            format.html {redirect_to album_photos_path(@album), notice: 'Photo was successfully created.'}
            @photos = [@photo]
            format.json {render 'index'}
          end
        else
          render 'new'
        end
      end
      ...
    end

And there it is, that was easy right? Setting the app to do uploads on rails is quite simple with paperclip. 
