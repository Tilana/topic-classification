import json
import os

from flask import Flask
from pyfakefs.fake_filesystem import FakeFilesystem


def test_embed(app: Flask) -> None:
    client = app.test_client()

    with app.test_request_context():
        resp = client.post('/embed',
                           data=json.dumps({
                               'seqs': ['hello world!'],
                               'bert': ('https://tfhub.dev/google/'
                                        'bert_uncased_L-12_H-768_A-12/1')
                           }),
                           content_type='application/json')
    assert resp.status == '200 OK'
    result = json.loads(resp.data)
    assert result
    assert result[0] > 10000


def test_classify(app: Flask, fs: FakeFilesystem) -> None:
    instance_path = os.path.join('./testdata/test_model/test_instance')
    fs.add_real_directory(instance_path)

    client = app.test_client()

    with app.test_request_context():
        resp = client.post(
            '/classify?model=test_model',
            data=json.dumps(
                {'seqs': ['take forceful action to improve childrens rights']}),
            content_type='application/json')
    assert resp.status == '200 OK'
    result = json.loads(resp.data)
    assert result
    assert result[0]['Rights of the Child'] >= 0.7


def test_all_model_status(app: Flask, fs: FakeFilesystem) -> None:
    fs.add_real_directory('./testdata/test_model/test_instance')
    fs.add_real_directory('./testdata/test_model/test_instance_unreleased')
    fs.add_real_directory('./testdata/test_other_model/test_instance')

    client = app.test_client()

    with app.test_request_context():
        resp = client.get('/models', content_type='application/json')
    assert resp.status == '200 OK'

    result = json.loads(resp.data)
    print(result)

    assert result
    assert len(result.keys()) == 2
    assert set(result.keys()) == set(['test_model', 'test_other_model'])
    assert result['test_other_model']['instances'] == ['test_instance']
    assert result['test_model']['instances'] == [
        'test_instance', 'test_instance_unreleased'
    ]
    assert result['test_model']['preferred'] == 'test_instance'
    # Pick two random test topics to assert
    assert result['test_model']['topics']['Asylum-seekers - refugees'] == {
        'name': 'Asylum-seekers - refugees',
        'quality': 1.0,
        'samples': 260
    }
    assert result['test_model']['topics'][
        'National Human Rights Institution'] == {
            'name': 'National Human Rights Institution',
            'quality': 1.0,
            'samples': 552
        }


def test_list_models(app: Flask, fs: FakeFilesystem) -> None:
    fs.add_real_directory('./testdata/test_model/test_instance')
    fs.add_real_directory('./testdata/test_model/test_instance_unreleased')
    fs.add_real_directory('./testdata/test_other_model/test_instance')

    client = app.test_client()

    with app.test_request_context():
        resp = client.get('/models/list', content_type='application/json')
    assert resp.status == '200 OK'

    result = json.loads(resp.data)

    assert result
    assert len(result.keys()) == 1
    assert set(result['models']) == set(['test_model', 'test_other_model'])


def test_list_models_filtered(app: Flask, fs: FakeFilesystem) -> None:
    fs.add_real_directory('./testdata/test_model/test_instance')
    fs.add_real_directory('./testdata/test_model/test_instance_unreleased')
    fs.add_real_directory('./testdata/test_other_model/test_instance')

    client = app.test_client()

    with app.test_request_context():
        resp = client.get('/models/list?filter=test_other',
                          content_type='application/json')
    assert resp.status == '200 OK'

    result = json.loads(resp.data)

    assert result
    assert len(result.keys()) == 1
    assert set(result['models']) == set(['test_other_model'])


def test_model_status(app: Flask, fs: FakeFilesystem) -> None:
    fs.add_real_directory('./testdata/test_model/test_instance')
    fs.add_real_directory('./testdata/test_model/test_instance_unreleased')

    client = app.test_client()

    with app.test_request_context():
        resp = client.get('/models?model=test_model',
                          content_type='application/json')
    assert resp.status == '200 OK'

    result = json.loads(resp.data)

    assert result
    assert result['instances'] == ['test_instance', 'test_instance_unreleased']
    assert result['preferred'] == 'test_instance'
    # Pick two random test topics to assert
    assert result['topics']['Asylum-seekers - refugees'] == {
        'name': 'Asylum-seekers - refugees',
        'quality': 1.0,
        'samples': 260
    }
    assert result['topics']['National Human Rights Institution'] == {
        'name': 'National Human Rights Institution',
        'quality': 1.0,
        'samples': 552
    }
