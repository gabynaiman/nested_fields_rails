jQuery(function($) {

    NestedFields = function(associationName) {
        this.associationName = associationName;

        this.add = function() {
            var template = $('#' + this.associationName + '_fields_template').html();
            var container = $('#' + this.associationName + '.nested-fields');
            var regexp = new RegExp("new_" + this.associationName, "g");
            var newId = new Date().getTime();
            container.append(template.replace(regexp, newId))
            this.updateIndex();
        };

        this.remove = function(objectId) {
            var fields = this.findFields(objectId);
            var destroyField = fields.find('.destroy');
            destroyField.val('true');
            fields.hide();
            this.updateIndex();
        };

        this.up = function(objectId) {
            var fields = this.findFields(objectId);
            var container = fields.closest('.nested-fields');
            var index = fields.index() - 1;

            if (index >= 0) {
                this.findFields(objectId).remove();
                container.children('.fields').eq(index).before(fields);
                this.updateIndex();
            }
        };

        this.down = function(objectId) {
            var fields = this.findFields(objectId);
            var container = fields.closest('.nested-fields');
            var index = fields.index();

            if (fields.index() < container.children('.fields').size()) {
                this.findFields(objectId).remove();
                container.children('.fields').eq(index).after(fields);
                this.updateIndex();
            }
        };

        this.findFields = function(objectId) {
            return $('#' + this.associationName + '.nested-fields .fields[data-object-id=' + objectId + ']');
        };

        this.updateIndex = function() {
            var container = $('#' + this.associationName + '.nested-fields');
            container.find('.index').each(function(index, element) {
                $(element).val(index);
            });
        }

        this.ids = function() {
            var ids = [];
            $('#' + this.associationName + '.nested-fields .fields').each(function(index, element) {
                ids.push($(element).attr('data-object-id'));
            });
            return ids;
        };
    };

    function nestedFieldContext(element) {
        var link = $(element);
        var fields = link.closest('.fields');
        var objectId = fields.attr('data-object-id');
        var container = fields.closest('.nested-fields');
        var associationName = container.attr('id');
        return {'associationName': associationName, 'objectId': objectId};
    };

    $('.add-nested-fields').on('click', function() {
        var link = $(this);
        var associationName = link.attr('data-association');
        new NestedFields(associationName).add();
    });

    $('.remove-nested-fields').on('click', function() {
        var context = nestedFieldContext(this);
        new NestedFields(context.associationName).remove(context.objectId);
    });

    $('.up-nested-fields').on('click', function() {
        var context = nestedFieldContext(this);
        new NestedFields(context.associationName).up(context.objectId);
    });

    $('.down-nested-fields').on('click', function() {
        var context = nestedFieldContext(this);
        new NestedFields(context.associationName).down(context.objectId);
    });

});