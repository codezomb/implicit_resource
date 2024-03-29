## ImplicitResource

[![Gem Version](https://badge.fury.io/rb/implicit_resource.svg)](https://badge.fury.io/rb/implicit_resource)

In most cases you will have the same old code in your controllers, this gem allows some very basic assumptions while giving you the option to override the behavior. This allows your controllers to be limited to just the required code.

Assumptions this code makes:
1. The controller is named for the model. e.g. `ArticlesController` will assume `Article` model.
2. Standard restful actions: `index`, `show`, `new`, `create`, `edit`, `update`, `destroy`.
3. A method named `permitted_attributes` exists for `permitted_params`.

Here's an example of the bare minimum code required to get started:

```ruby
ArticlesController < ApplicationController
  include ImplicitResource # Opt in to implicit behavior, or include it in ApplicationController.

  private

  def permitted_params
    params.require(:article).permit(:title, :body)
  end
end
```

## Installationc
Add this line to your application's Gemfile:

```ruby
gem "implicit_resource"
```

Add this line to your controller

```ruby
include ImplicitResource
```

### Customization

ImplicitResource only targets basic controller functionality. Everything that `implicit_resource` does can be overriden in the controller.

#### Overriding resource methods

You can override the `collection` and `resource` methods to achieve more flexibility in how things are queried.

```ruby
ArticlesController < ApplicationController
  include ImplicitResource

  private

  def collection # Collection is a placeholder for any collection of objects to be returned
    model_klass.includes(:comments).search(title: params[:title_search_terms])
  end

  def resource # Resource is a placeholder for any single object to be returned
    collection.find_by(token_id: params[:token_id])
  end
end
```

#### Overriding the model class

You can override the `model_klass` method to allow for controller/model naming mismatch.

```ruby
ArticlesController < ApplicationController
  include ImplicitResource

  private

  def model_klass
    Story
  end
end
```

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
