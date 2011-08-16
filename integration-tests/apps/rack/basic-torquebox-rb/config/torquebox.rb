TorqueBox.configure do
  environment 'biscuit' => 'gravy'
  
  environment { 
    HAM :biscuit
  }

  options_for Backgroundable, :disabled => true

  pool :foo, :type => :bounded, :min => 0, :max => 6

  pool :cheddar do
    type :bounded
    min 0
    max 6
  end

  job AJob, :name => :a_job, :cron => '*/1 * * * * ?'
  
  queue '/queue/a-queue', :durable => false

  queue '/queue/another-queue', :durable => false do
    processor AProcessor, :concurrency => 2, :filter => "steak = 'salad'", :config => { :foo => :bar }
  end

  queue '/queue/yet-another-queue' do
    durable false
    processor AProcessor do
      concurrency 2
      filter "steak = 'salad'"
      config(:foo => :bar)
    end
  end

  topic '/topic/a-topic', :durable => false

  ruby :version => '1.9'

  service AService, :name => 'a-service', :config => { :foo => :bar }

  service AnotherService do
    name 'another_service'
  end
  
  web :context => '/torquebox-rb'

  authentication :ham, :domain => 'torquebox-auth'
  authentication :biscuit do
    domain 'torquebox-auth'
  end
end