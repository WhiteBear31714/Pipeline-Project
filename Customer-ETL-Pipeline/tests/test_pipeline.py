from pipeline_Python.pipeline import extract_data

def test_extract_data():
    # Execute extract task
    data = extract_data.fn()

    # Verify extracted tables
    assert "customers" in data
    assert "orders" in data
    assert "rates" in data