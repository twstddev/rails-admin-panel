/**
 * @brief Script provides very basic minimum
 * for dynamic fields management. Take it as a 
 * dirty hack %)
 */
( function( $ ) {
	/**
	 * @brief A factory that prepares and creates 
	 * meta fields sets.
	 */
	var MetaFieldsFactory = ( function() {
		// private scope
		var PrivateScope = function() {
			this.add_selector = "";
			this.remove_selector = "";
			this.set_selector = "";
		};

		/**
		 * @brief Prepares the object.
		 */
		PrivateScope.prototype.initialize = function() {
			this.bindToButtons();
			this.bindToRemoveButtons();
			this.makeSetsSortable();
		}

		/**
		 * @brief Binds click listeners to add buttons on the page.
		 */
		PrivateScope.prototype.bindToButtons = function() {
			var that = this;

			$( document ).on( "click", this.add_selector, function( event ) {
				event.preventDefault();

				that.appendFields.call( that, this )
			} );
		}

		/**
		 * @brief Binds to click on remove button that
		 * remove selected set of fields.
		 */
		PrivateScope.prototype.bindToRemoveButtons = function() {
			$( document ).on( "click", this.remove_selector, function( event ) {
				event.preventDefault();

				$( this ).parent().remove();
			} );
		}

		/**
		 * @brief Grabs all fields sets on the page
		 * and applies a sortable functionality to them.
		 */
		PrivateScope.prototype.makeSetsSortable = function() {
			$( this.set_selector ).sortable( {
				items : "> fieldset"
			} );
		}

		/**
		 * @brief Appends fields elements to the closest
		 * container of fields.
		 */
		PrivateScope.prototype.appendFields = function( button ) {
			var $button = $( button );
			var $closest_fields_container = $button.prev( this.set_selector );
			var current_index = $closest_fields_container.data( "index" );
			var placeholder = new RegExp( $button.data( "placeholder" ), "g" );
			var fields_html = $button.data( "html" ).replace( placeholder, current_index );

			$closest_fields_container.append( fields_html );
			$closest_fields_container.data( "index", current_index + 1 );
		}

		var m_d = null;

		return {
			/**
			 * @brief Fake constructor.
			 */
			init : function( config ) {
				// create cheshire cat 
				m_d = new PrivateScope();
				m_d.add_selector = config[ "button_selector" ];
				m_d.remove_selector = config[ "remove_selector" ];
				m_d.set_selector = config[ "set_selector" ];
				m_d.initialize();
			}
		}
	} )();

	$( function() {
		MetaFieldsFactory.init( {
			button_selector : ".btn.has-many-meta",
			remove_selector : ".btn.has-many-remove",
			set_selector : ".nested-meta-fields"
		} );
	} );
} )( jQuery );
