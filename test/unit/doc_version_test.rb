require File.expand_path("../../test_helper", __FILE__)

class DocVersionTest < ActiveSupport::TestCase
  test 'finds most recent version' do
    range = 0..3
    file = Factory(:doc_file, :name => 'test-command')
    docs = range.map{|i| Factory(:doc, :plain => "Doc #{i}")}
    vers = range.map{|i| Factory(:version, :name => "v#{i}.0")}
    dver = range.map{|i| Factory(:doc_version, :doc_file => file, :version => vers[i], :doc => docs[i])}

    dv = DocVersion.latest_for('test-command')
    assert_equal docs[3], dv.doc
  end

  test 'finds a specific version' do
    range = 0..3
    file = Factory(:doc_file, :name => 'test-command')
    docs = range.map{|i| Factory(:doc, :plain => "Doc #{i}")}
    vers = range.map{|i| Factory(:version, :name => "v#{i}.0")}
    dver = range.map{|i| Factory(:doc_version, :doc_file => file, :version => vers[i], :doc => docs[i])}

    dv = DocVersion.for_version('test-command', 'v2.0')
    assert_equal docs[2], dv.doc
  end
end