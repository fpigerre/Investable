Tabulous.setup do

  tabs do

    overview_tab do
      text { 'Overview' }
      link_path { bitcoin_path }
      visible_when { true }
      enabled_when { true }
      active_when { in_action('overview').of_controller('bitcoin') }
    end

    bitfinex_tab do
      text { 'Bitfinex' }
      link_path { bitfinex_path }
      visible_when { true }
      enabled_when { true }
      active_when { in_action('bitfinex').of_controller('bitcoin') }
    end

    bitstamp_tab do
      text { 'Bitstamp' }
      link_path { bitstamp_path }
      visible_when { true }
      enabled_when { true }
      active_when { in_action('bitstamp').of_controller('bitcoin') }
    end

    btcchina_tab do
      text { 'BTC China' }
      link_path { btcchina_path }
      visible_when { true }
      enabled_when { true }
      active_when { in_action('btcchina').of_controller('bitcoin') }
    end

    okcoin_tab do
      text { 'OKCoin' }
      link_path { okcoin_path }
      visible_when { true }
      enabled_when { true }
      active_when { in_action('okcoin').of_controller('bitcoin') }
    end

  end

  customize do

    # which class to use to generate HTML
    # :default, :html5, :bootstrap, :bootstrap_pill or :bootstrap_navbar
    # or create your own renderer class and reference it here
    # renderer :default

    # whether to allow the active tab to be clicked
    # defaults to true
    # active_tab_clickable true

    # what to do when there is no active tab for the current controller action
    # :render -- draw the tabset, even though no tab is active
    # :do_not_render -- do not draw the tabset
    # :raise_error -- raise an error
    # defaults to :do_not_render
    when_action_has_no_tab :render

    # whether to always add the HTML markup for subtabs, even if empty
    # defaults to false
    # render_subtabs_when_empty false

  end

  # The following will insert some CSS straight into your HTML so that you
  # can quickly prototype an app with halfway-decent looking tabs.
  #
  # This scaffolding should be turned off and replaced by your own custom
  # CSS before using tabulous in production.
  use_css_scaffolding do
    background_color '#CCCCCC'
    text_color '#444444'
    active_tab_color '#FFFFFF'
    hover_tab_color '#DDDDDD'
    inactive_tab_color '#AAAAAA'
    inactive_text_color '#888888'
  end

end
